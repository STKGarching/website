from flask import Flask
from flask import request
from flask_restful import Resource, Api
from flask_restful import reqparse
#from flask.ext.mysql import MySQL
from flaskext.mysql import MySQL
import json

app = Flask(__name__)
api = Api(app)
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'pass'
app.config['MYSQL_DATABASE_DB'] = 'sport'

mysql = MySQL(app)
QUERY_SELECT_COURT_STATUS = """
SELECT
    cs.court_no,
    csl.court_status_name,
    c.court_surface,
    c.court_type
FROM
    club.court_status cs
        LEFT JOIN
    club.court_status_list csl ON cs.court_status_list_id = csl.court_status_list_id
        LEFT JOIN
    club.court c ON cs.court_no = c.court_no
WHERE
    1 = 1 AND cs.valid_to > {0}
        AND cs.valid_from <= {0}
        AND c.valid_to > {0}
        AND c.valid_from <= {0}
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


class HelloWorld(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('team_members_id', required=True, help="team_members_id cannot be blank!")
        args = parser.parse_args() 
        return args['team_members_id']

class Benefit(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('team_members_id', required=True, help="team_members_id cannot be blank!")
        args = parser.parse_args()        
        sql_benefit = 'select team_members_id, team_id, player_id, is_main_team from team_members where team_members_id={0}'.format(args['team_members_id'])
        benefit = _fetch_data_in_database(sql_benefit)
        #print(benefit)
        column = ['team_members_id', 'team_id', 'player_id', 'is_main_team']
        items = [dict(zip(column, row)) for row in benefit]
        return items
        
class court_status(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('date', required=True, help="date cannot be blank!")
        args = parser.parse_args()        
        sql_court_status = QUERY_SELECT_COURT_STATUS.format(args['date'])
        court_status = _fetch_data_in_database(sql_court_status)
        column = ['court_no', 'court_status_name', 'court_surface', 'court_type']
        items = [dict(zip(column, row)) for row in court_status]
        return items

class all_tasks(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        #parser.add_argument('date', required=True, help="date cannot be blank!")
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
api.add_resource(Benefit, '/benefit')
api.add_resource(court_status, '/court_status')
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