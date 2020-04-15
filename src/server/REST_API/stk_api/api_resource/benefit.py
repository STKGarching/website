from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class Benefit(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('members_no', required=True,
                            help="members_no cannot be blank!")
        parser.add_argument('valid_from', required=True,
                            help="valid_from cannot be blank!")
        parser.add_argument('valid_to', required=True,
                            help="valid_to cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT_BENEFIT = file_processor.read_sql_file(
            "sql/select_benefit.sql")
        sql_benefit = QUERY_SELECT_BENEFIT.format(
            args['members_no'], args['valid_from'], args['valid_to'])
        benefit = database_processor.fetch_data_in_database(sql_benefit)
        column = ['member_no', 'description', 'sum_part_time', 'sum_claim']
        items = [dict(zip(column, row)) for row in benefit]
        return items