from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse
from flask import request

class AddPerson(Resource):
    def put(self):
        person_no = request.args.get('person_no')
        is_member = request.args.get('is_member')
        member_no = request.args.get('member_no')
        first_name = request.args.get('first_name')
        last_name = request.args.get('last_name')
        QUERY_INSERT_PERSON = file_processor.read_sql_file(
            "sql/insert_person.sql")
        sql_insert_person = QUERY_INSERT_PERSON.format(
            person_no, is_member, member_no, "\'{}\'".format(first_name), "\'{}\'".format(last_name))
        database_processor.insert_data_into_database(sql_insert_person)
        return 201