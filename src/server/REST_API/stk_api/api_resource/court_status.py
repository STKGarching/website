from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class GetCourtStatus(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('date', required=True,
                            help="date cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT_COURT_STATUS_DATE = file_processor.read_sql_file(
            "sql/select_court_status_date.sql")
        sql_court_status = QUERY_SELECT_COURT_STATUS_DATE.format(args['date'])
        court_status = database_processor.fetch_data_in_database(
            sql_court_status)
        column = ['court_id', 'court_no', 'court_status_name',
                  'court_surface', 'court_type']
        items = [dict(zip(column, row)) for row in court_status]
        return items