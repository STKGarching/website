from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class CourtStatusList(Resource):
    def get(self):
        sql_court_status_list = file_processor.read_sql_file(
            "sql/select_court_status_list.sql")
        all_court_status_list = database_processor.fetch_data_in_database(
            sql_court_status_list)
        column = ['court_status_list_id', 'court_status_name']
        items = [dict(zip(column, row)) for row in all_court_status_list]
        return items