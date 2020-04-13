from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class PersonInfo(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('person_no', required=True,
                            help="person_no cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT_PERSON_INFO = file_processor.read_sql_file(
            "sql/select_person_info.sql")
        sql_person_info = QUERY_SELECT_PERSON_INFO.format(
            "\'{}\'".format(args['person_no']))
        person_info = database_processor.fetch_data_in_database(
            sql_person_info)
        column = ['person_no', 'first_name', 'last_name', 'member_no', 'role']
        items = [dict(zip(column, row)) for row in person_info]
        return items