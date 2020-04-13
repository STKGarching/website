from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

QUERY_CALL_COURT_STATUS_INSERT = """
CALL club.p_court_status_insert({0},{1},{2},{3},{4})
"""

class courtStatusUpdate(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('court_id', required=True,
                            help="court_id cannot be blank!")
        parser.add_argument('court_status_list_id', required=True,
                            help="court_status_list_id cannot be blank!")
        parser.add_argument('valid_from', required=True,
                            help="valid_from cannot be blank!")
        parser.add_argument('valid_to', required=True,
                            help="valid_to cannot be blank!")
        parser.add_argument('changed_by', required=True,
                            help="changed_by cannot be blank!")
        args = parser.parse_args()
        sql_court_status_update = QUERY_CALL_COURT_STATUS_INSERT.format(
            args['court_id'], args['court_status_list_id'], args['valid_from'], args['valid_to'], args['changed_by'])
        court_status_update = database_processor.fetch_data_in_database(
            sql_court_status_update)
        column = ['update_status']
        items = [dict(zip(column, row)) for row in court_status_update]
        return items

