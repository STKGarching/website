from flask import Flask
from flask import request
from flask_cors import CORS
from flask_restful import Resource, Api
from flask_restful import reqparse
from flask_swagger_ui import get_swaggerui_blueprint
from flaskext.mysql import MySQL
import json
import yaml

with open(r'../../../../config.yaml') as file:
    config = yaml.load(file, Loader=yaml.FullLoader)

app = Flask(__name__)
CORS(app)
api = Api(app)
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_USER'] = config['database']['username']
app.config['MYSQL_DATABASE_PASSWORD'] = config['database']['password']
app.config['MYSQL_DATABASE_DB'] = 'sport'

### swagger specific ###
SWAGGER_URL = '/swagger'
API_URL = '/static/swagger.json'
SWAGGERUI_BLUEPRINT = get_swaggerui_blueprint(
    SWAGGER_URL,
    API_URL,
    config={
        'app_name': "STK Garching API"
    }
)
app.register_blueprint(SWAGGERUI_BLUEPRINT, url_prefix=SWAGGER_URL)
### end swagger specific ###


mysql = MySQL(app)
QUERY_SELECT_PERSON_INFO = """
SELECT
    p.person_no, p.first_name, p.last_name, p.member_no, ro.role
FROM
    club.person p
        LEFT JOIN
    club.relationship r ON p.person_id = r.source_id
        LEFT JOIN
    club.relationship_type rt ON r.relationship_type_id = rt.relationship_type_id
        LEFT JOIN
    club.role ro ON r.target_id = ro.role_id
WHERE 1 = 1
AND rt.relationship_type_no = 6
AND p.person_no = {0}
"""

QUERY_SELECT_COURT_STATUS_DATE = """
SELECT
    c.court_id,
    c.court_no,
    csl.court_status_name,
    c.court_surface,
    c.court_type
FROM
    club.court_status cs
        LEFT JOIN
    club.court_status_list csl ON cs.court_status_list_id = csl.court_status_list_id
        LEFT JOIN
    club.court c ON cs.court_id = c.court_id
WHERE
    1 = 1 AND cs.valid_to > {0}
        AND cs.valid_from <= {0}
        AND c.valid_to > {0}
        AND c.valid_from <= {0}
"""

QUERY_CALL_COURT_STATUS_INSERT = """
CALL club.p_court_status_insert({0},{1},{2},{3},{4})
"""

QUERY_SELECT_COURT_STATUS_LIST = """
SELECT
    c.court_status_list_id, c.court_status_name
FROM
    club.court_status_list c
"""

QUERY_SELECT_ALL_TASKS = """
SELECT
    t.task_no,
    t.title,
    CAST(t.description AS char),
    CAST(t.created_at AS char),
    CAST(t.modified_at AS char),
    t.due_date,
    t.resolution_date,
    tp.task_priority,
    ts.task_status
FROM
    club.task t
        LEFT JOIN
    club.task_priority tp ON t.task_priority_id = tp.task_priority_id
        LEFT JOIN
    club.task_status ts ON t.task_status_id = ts.task_status_id;
"""

QUERY_SELECT_TASK_DETAIL = """
SELECT
    rt.relationship_type,
    -- Für einen Link zum Profil
    p.person_no,
    p.first_name,
    p.last_name
FROM
    club.task t
        LEFT JOIN
    club.relationship r ON t.task_id = r.source_id
        LEFT JOIN
    club.person p ON r.target_id = p.person_id
        LEFT JOIN
    club.relationship_type rt ON r.relationship_type_id = rt.relationship_type_id
WHERE
    1 = 1 AND r.source = 'task'
        AND r.target = 'person'
        AND t.task_no = {0};
"""

QUERY_SELECT_BENEFIT = """
SELECT
    basis.member_no,
    basis.description,
    basis.sum_part_time,
    IF(basis.is_claimable,
        basis.sum_claim,
        basis.sum_part_time) AS sum_claim
FROM
    (SELECT
        p.member_no,
            b.description,
            -- Benefits die vom Betrachtungszeitraum abweichen sollen nur anteilig eingerechnet werden.
            sport.date_period_part({1},{2},b.valid_from,b.valid_to) * IF(ISNULL(b.value), b.cap_sum_value, b.count * b.value) / cnt_team_members AS sum_part_time,
            c.value / cnt_team_members AS sum_claim,
            b.is_claimable
    FROM
        sport.benefit b
    -- Die Summe der tatsächlich eingeforderten Benefitsumme pro benefit_id
    LEFT JOIN (SELECT
        c.benefit_id, SUM(c.value) AS value
    FROM
        sport.claim c
    WHERE
        1 = 1 AND c.created_at >= {1}
            AND c.created_at < {2}
    GROUP BY c.benefit_id) c ON c.benefit_id = b.benefit_id
    LEFT JOIN sport.team t ON b.entity_id = t.team_id
    LEFT JOIN sport.team_members tm ON t.team_id = tm.team_id
    LEFT JOIN (SELECT
        tm.team_id, COUNT(*) AS cnt_team_members
    FROM
        sport.team_members tm
    WHERE
        1 = 1 AND tm.is_main_team = TRUE
    GROUP BY team_id) tm_count ON tm.team_id = tm_count.team_id
    LEFT JOIN sport.player p ON tm.player_id = p.player_id
    LEFT JOIN club.person pers ON p.member_no = p.member_no
    WHERE
        1 = 1 AND entity = 'team'
            AND p.member_no = {0}
            AND ((b.valid_from <= {1}
            AND b.valid_to > {1})
            OR (b.valid_from < {2}
            AND b.valid_to >= {2})
            OR (b.valid_from >= {1}
            AND b.valid_from < {2}))
	UNION
  -- Benefits pro Einzelspieler
    SELECT
        p.member_no,
            b.description,
            -- Benefits die vom Betrachtungszeitraum abweichen sollen nur anteilig eingerechnet werden.
            sport.date_period_part({1},{2},b.valid_from,b.valid_to) * IF(ISNULL(b.value), b.cap_sum_value, b.count * b.value) AS sum_part_time,
            c.value AS sum_claim,
            b.is_claimable
    FROM
        sport.benefit b
    LEFT JOIN sport.player p ON b.entity_id = p.player_id
    -- Die Summe der tatsächlich eingeforderten Benefitsumme pro benefit_id
    LEFT JOIN (SELECT
        c.benefit_id, SUM(c.value) AS value
    FROM
        sport.claim c
    WHERE
        1 = 1 AND c.created_at >= {1}
            AND c.created_at < {2}
    GROUP BY c.benefit_id) c ON c.benefit_id = b.benefit_id
    LEFT JOIN club.person pers ON p.member_no = p.member_no
    WHERE
        1 = 1 AND entity = 'player'
            AND p.member_no = {0}
            AND ((b.valid_from <= {1}
            AND b.valid_to > {1})
            OR (b.valid_from < {2}
            AND b.valid_to >= {2})
            OR (b.valid_from >= {1}
            AND b.valid_from < {2}))) basis

"""

class HelloWorld(Resource):
    def get(self):
        return """
          <html>
            <head>
              Welcome to STK Garching API.
            </head>
            <body>
              For more information check this link:{0}/swagger
            </body></html>"
        """.format(request.url)

class person_info(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('person_no', required=True, help="person_no cannot be blank!")
        args = parser.parse_args()
        sql_person_info = QUERY_SELECT_PERSON_INFO.format(args['person_no'])
        person_info = _fetch_data_in_database(sql_person_info)
        column = ['person_no','first_name', 'last_name', 'member_no', 'role']
        items = [dict(zip(column, row)) for row in person_info]
        return items

class benefit(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('members_no', required=True, help="members_no cannot be blank!")
        parser.add_argument('valid_from', required=True, help="valid_from cannot be blank!")
        parser.add_argument('valid_to', required=True, help="valid_to cannot be blank!")
        args = parser.parse_args()
        sql_benefit = QUERY_SELECT_BENEFIT.format(args['members_no'], args['valid_from'], args['valid_to'])
        benefit = _fetch_data_in_database(sql_benefit)
        column = ['member_no', 'description', 'sum_part_time', 'sum_claim']
        items = [dict(zip(column, row)) for row in benefit]
        return items

class court_status_list(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        args = parser.parse_args()
        sql_court_status_list = QUERY_SELECT_COURT_STATUS_LIST
        all_court_status_list = _fetch_data_in_database(sql_court_status_list)
        column = ['court_status_list_id', 'court_status_name']
        items = [dict(zip(column, row)) for row in all_court_status_list]
        return items

class court_status(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('date', required=True, help="date cannot be blank!")
        args = parser.parse_args()
        sql_court_status = QUERY_SELECT_COURT_STATUS_DATE.format(args['date'])
        court_status = _fetch_data_in_database(sql_court_status)
        column = ['court_id', 'court_no', 'court_status_name', 'court_surface', 'court_type']
        items = [dict(zip(column, row)) for row in court_status]
        return items

class court_status_update(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('court_id', required=True, help="court_id cannot be blank!")
        parser.add_argument('court_status_list_id', required=True, help="court_status_list_id cannot be blank!")
        parser.add_argument('valid_from', required=True, help="valid_from cannot be blank!")
        parser.add_argument('valid_to', required=True, help="valid_to cannot be blank!")
        parser.add_argument('changed_by', required=True, help="changed_by cannot be blank!")
        args = parser.parse_args()
        sql_court_status_update = QUERY_CALL_COURT_STATUS_INSERT.format(args['court_id'],args['court_status_list_id'],args['valid_from'],args['valid_to'],args['changed_by'])
        court_status_update = _fetch_data_in_database(sql_court_status_update)
        column = ['update_status']
        items = [dict(zip(column, row)) for row in court_status_update]
        return items

class all_tasks(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        args = parser.parse_args()
        sql_all_tasks = QUERY_SELECT_ALL_TASKS
        all_tasks = _fetch_data_in_database(sql_all_tasks)
        column = ['task_no', 'title', 'description', 'created_at', 'modified_at', 'due_date', 'resolution_date', 'priority', 'task_status']
        items = [dict(zip(column, row)) for row in all_tasks]
        return items

class task_detail(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('task_no', required=True, help="task_no cannot be blank!")
        args = parser.parse_args()
        sql_task_detail = QUERY_SELECT_TASK_DETAIL.format(args['task_no'])
        task_detail = _fetch_data_in_database(sql_task_detail)
        column = ['relationship_type', 'person_no', 'first_name', 'last_name']
        items = [dict(zip(column, row)) for row in task_detail]
        return items

api.add_resource(HelloWorld, '/')
api.add_resource(person_info, '/person_info')
api.add_resource(benefit, '/benefit')
api.add_resource(court_status_list, '/court_status_list')
api.add_resource(court_status, '/court_status')
api.add_resource(court_status_update, '/court_status/update')
api.add_resource(all_tasks, '/all_tasks')
api.add_resource(task_detail, '/task_detail')


def _fetch_data_in_database(sql):
    connection = mysql.connect()
    cursor = connection.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

if __name__ == '__main__':
    app.run(debug=True)
