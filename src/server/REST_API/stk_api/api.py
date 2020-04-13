from flask import Flask
from flask import request, jsonify
from flask_cors import CORS
from flask_restful import Resource, Api
from flask_restful import reqparse
from flask_swagger_ui import get_swaggerui_blueprint
from flaskext.mysql import MySQL
import json
import yaml
import os
import psycopg2
from utils import file_processor, database_processor
import urllib.request
from api_resource import hello_api, all_tasks, person_info, court_status, court_status_list, benefit, court_status_update
from api_resource import task_detail, add_person, add_court, court_status_date, add_court_status, court_status_now, task_comments
from api_resource import upload_file

app = Flask(__name__)
CORS(app)
api = Api(app)

### swagger specific ###
SWAGGER_URL = "/swagger/"
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


class get_court_status_list(Resource):
    def get(self):
        QUERY_SELECT = file_processor.read_sql_file(
            "sql/court_status_list.sql")
        sql_statement = QUERY_SELECT
        row_list = database_processor.fetch_data_in_database(sql_statement)
        column = ['court_status_list_id', 'court_status_name']
        items = [dict(zip(column, row)) for row in row_list]
        return items


class get_personen_info(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('person_no', required=True,
                            help="person_no cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT = file_processor.read_sql_file(
            "sql/select_person_info.sql")
        sql_statement = QUERY_SELECT.format("\'{}\'".format(args['person_no']))
        row_list = database_processor.fetch_data_in_database(sql_statement)
        column = ['person_no', 'first_name', 'last_name', 'member_no', 'role']
        items = [dict(zip(column, row)) for row in row_list]
        return items


api.add_resource(hello_api.HelloAPI, '/')
api.add_resource(all_tasks.GetAllTasks, '/get_all_tasks', resource_class_kwargs={ 'database_processor': database_processor} )
api.add_resource(person_info.PersonInfo, '/person_info')
api.add_resource(court_status.GetCourtStatus, '/get_court_status')
api.add_resource(court_status_list.CourtStatusList, '/court_status_list')
api.add_resource(benefit.Benefit, '/benefit')
api.add_resource(court_status_update.courtStatusUpdate, '/court_status/update')
api.add_resource(task_detail.TaskDetail, '/task_detail')
api.add_resource(add_person.AddPerson, '/add_person')
api.add_resource(court_status_date.GetCourtStatusDate,
                 '/get_court_status_date')
api.add_resource(add_court_status.AddCourtStatus, '/add_court_status')
api.add_resource(court_status_now.GetCourtStatusNow, '/get_court_status_now')
api.add_resource(task_comments.GetTaskComments, '/get_task_comments')
api.add_resource(add_court.AddCourt, '/add_court')


api.add_resource(get_court_status_list, '/get_court_status_list')

api.add_resource(get_personen_info, '/get_personen_info')

api.add_resource(upload_file.UploadFile, '/upload_file')

if __name__ == '__main__':
    app.run(debug=True)
