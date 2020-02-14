from flask import Flask
from flask import request
from flask_cors import CORS
from flask_restful import Resource, Api
from flask_restful import reqparse
from flask_swagger_ui import get_swaggerui_blueprint
from flaskext.mysql import MySQL
import json
import yaml
import psycopg2

#with open(r'../../../../config.yaml') as file:
#    config = yaml.load(file, Loader=yaml.FullLoader)

app = Flask(__name__)
CORS(app)
api = Api(app)
### mysql stuff start ###
#app.config['MYSQL_DATABASE_HOST'] = 'localhost'
#app.config['MYSQL_DATABASE_USER'] = config['database']['username']
#app.config['MYSQL_DATABASE_PASSWORD'] = config['database']['password']
#app.config['MYSQL_DATABASE_DB'] = 'sport'
### mysql stuff end ###

### postgresql stuff start ###
connection = psycopg2.connect(host="localhost",database="stkgarching", user="admin", password="admin")
### postgresql stuff end ###


### swagger specific ###
SWAGGER_URL = "/swagger"
API_URL = "/static/swagger.json"
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
        QUERY_SELECT_PERSON_INFO = _read_sql_file("sql/select_person_info.sql")
        sql_person_info = QUERY_SELECT_PERSON_INFO.format("\'{}\'".format(args['person_no']))
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
        QUERY_SELECT_BENEFIT = _read_sql_file("sql/select_benefit.sql")
        sql_benefit = QUERY_SELECT_BENEFIT.format(args['members_no'], args['valid_from'], args['valid_to'])
        benefit = _fetch_data_in_database(sql_benefit)
        column = ['member_no', 'description', 'sum_part_time', 'sum_claim']
        items = [dict(zip(column, row)) for row in benefit]
        return items

class court_status_list(Resource):
    def get(self):
        sql_court_status_list = _read_sql_file("sql/select_court_status_list.sql")
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
        QUERY_SELECT_ALL_TASKS = _read_sql_file("sql/select_all_tasks.sql")
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
        QUERY_SELECT_TASK_DETAIL = _read_sql_file("sql/select_task_details.sql")
        sql_task_detail = QUERY_SELECT_TASK_DETAIL.format(args['task_no'])
        task_detail = _fetch_data_in_database(sql_task_detail)
        column = ['relationship_type', 'person_no', 'first_name', 'last_name']
        items = [dict(zip(column, row)) for row in task_detail]
        return items

class add_person(Resource):
    def put(self):
        person_no = request.args.get('person_no')
        is_member =  request.args.get('is_member')
        member_no = request.args.get('member_no')
        first_name = request.args.get('first_name')
        last_name = request.args.get('last_name')
        QUERY_INSERT_PERSON = _read_sql_file("sql/insert_person.sql")
        sql_insert_person = QUERY_INSERT_PERSON.format(person_no, is_member, member_no, "\'{}\'".format(first_name), "\'{}\'".format(last_name))
        _insert_data_into_database(sql_insert_person)
        return 201

class add_court(Resource):
    def put(self):        
        court_id = request.args.get('court_id')
        if not request.args.get("court_id"):           
            raise RuntimeError("court_id is missing")        
        court_no = request.args.get('court_no')
        if not request.args.get("court_no"):           
            raise RuntimeError("court_no is missing")           
        court_surface = request.args.get('court_surface')
        if not request.args.get("court_surface"):           
            raise RuntimeError("court_surface is missing")          
        court_type = request.args.get('court_type')
        if not request.args.get("court_type"):           
            raise RuntimeError("court_type is missing")           
        valid_from = request.args.get('valid_from')
        if not request.args.get("valid_from"):           
            raise RuntimeError("valid_from is missing")           
        valid_to = request.args.get('valid_to')
        if not request.args.get("valid_to"):           
            raise RuntimeError("valid_to is missing")                          
        changed_by = request.args.get('changed_by')
        if not request.args.get("changed_by"):           
            raise RuntimeError("changed_by is missing")                  
        modified_at = request.args.get('modified_at')       
        if modified_at == '':
            modified_at = 'NULL'
        QUERY_INSERT_COURT = _read_sql_file("sql/insert_court.sql")
        sql_insert_court = QUERY_INSERT_COURT.format(court_id, court_no, "\'{}\'".format(court_surface), "\'{}\'".format(court_type), "\'{}\'".format(valid_from), "\'{}\'".format(valid_to), modified_at, "\'{}\'".format(changed_by))
        _insert_data_into_database(sql_insert_court)
        return 201        

class get_court_status_date(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('date', required=True, help="date cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT = _read_sql_file("sql/court_status_date.sql")
        sql_statement = QUERY_SELECT.format(args['date'])
        row_list = _fetch_data_in_database(sql_statement)
        column = ['court_id', 'court_no', 'court_status_name', 'court_surface', 'court_type']
        items = [dict(zip(column, row)) for row in row_list]
        return items


class add_court_status(Resource):
    def put(self):
        #court_id, court_status_list_id, valid_from, valid_to, modified_at, changed_by
        court_id = request.args.get('court_id')
        if not request.args.get("court_id"):           
            raise RuntimeError("court_id is missing")        
        court_status_list_id = request.args.get('court_status_list_id')
        if not request.args.get("court_status_list_id"):           
            raise RuntimeError("court_status_list_id is missing")                    
        valid_from = request.args.get('valid_from')
        if not request.args.get("valid_from"):           
            raise RuntimeError("valid_from is missing")           
        valid_to = request.args.get('valid_to')
        if not request.args.get("valid_to"):           
            raise RuntimeError("valid_to is missing")                          
        changed_by = request.args.get('changed_by')
        if not request.args.get("changed_by"):           
            raise RuntimeError("changed_by is missing")                  
        modified_at = request.args.get('modified_at')       
        if modified_at == '':
            modified_at = 'NULL'
        QUERY_INSERT = _read_sql_file("sql/court_status_insert.sql")
        sql_insert_statement = QUERY_INSERT.format(court_id, court_status_list_id, "\'{}\'".format(valid_from), "\'{}\'".format(valid_to), modified_at, "\'{}\'".format(changed_by))
        _insert_data_into_database(sql_insert_statement)
        return 201       

class get_court_status_list(Resource):
    def get(self):       
        QUERY_SELECT = _read_sql_file("sql/court_status_list.sql")
        sql_statement = QUERY_SELECT
        row_list = _fetch_data_in_database(sql_statement)
        column = ['court_status_list_id', 'court_status_name']
        items = [dict(zip(column, row)) for row in row_list]
        return items

class get_court_status_now(Resource):
    def get(self):       
        QUERY_SELECT = _read_sql_file("sql/court_status_now.sql")
        sql_statement = QUERY_SELECT
        row_list = _fetch_data_in_database(sql_statement)
        column = ['court_no', 'court_status_name','court_surface','court_type']
        items = [dict(zip(column, row)) for row in row_list]
        return items       

class get_personen_info(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('person_no', required=True, help="person_no cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT = _read_sql_file("sql/select_person_info.sql")
        sql_statement = QUERY_SELECT.format("\'{}\'".format(args['person_no'])) 
        row_list = _fetch_data_in_database(sql_statement)
        column = ['person_no', 'first_name', 'last_name', 'member_no', 'role']
        items = [dict(zip(column, row)) for row in row_list]
        return items

api.add_resource(HelloWorld, '/')
api.add_resource(person_info, '/person_info')
api.add_resource(benefit, '/benefit')
api.add_resource(court_status_list, '/court_status_list')
api.add_resource(court_status, '/court_status')
api.add_resource(court_status_update, '/court_status/update')
api.add_resource(all_tasks, '/all_tasks')
api.add_resource(task_detail, '/task_detail')
api.add_resource(add_person, '/add_person')
api.add_resource(add_court, '/add_court')
api.add_resource(get_court_status_date, '/get_court_status_date')
api.add_resource(add_court_status, '/add_court_status')
api.add_resource(get_court_status_list, '/get_court_status_list')
api.add_resource(get_court_status_now, '/get_court_status_now') 
api.add_resource(get_personen_info, '/get_personen_info') 

def _fetch_data_in_database(sql):
    #connection = mysql.connect()
    cursor = connection.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def _insert_data_into_database(sql):    
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()

def _read_sql_file(input_file):
    sql_statement = ""
    with open(input_file, 'r') as file:
        sql_statement = file.read().replace('\n', ' ')

    return sql_statement   

if __name__ == '__main__':
    app.run(debug=True)
