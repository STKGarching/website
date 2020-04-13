from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class GetCourtStatusDate(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('date', required=True,
                            help="date cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT = file_processor.read_sql_file(
            "sql/court_status_date.sql")
        sql_statement = QUERY_SELECT.format(args['date'])
        row_list = database_processor.fetch_data_in_database(sql_statement)
        column = ['court_id', 'court_no', 'court_status_name',
                  'court_surface', 'court_type']
        items = [dict(zip(column, row)) for row in row_list]
        return items
