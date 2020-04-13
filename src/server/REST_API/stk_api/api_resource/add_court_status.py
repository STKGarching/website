from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse
from flask import request

class AddCourtStatus(Resource):
    def put(self):
        # court_id, court_status_list_id, valid_from, valid_to, modified_at, changed_by
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
        QUERY_INSERT = file_processor.read_sql_file(
            "sql/court_status_insert.sql")
        sql_insert_statement = QUERY_INSERT.format(court_id, court_status_list_id, "\'{}\'".format(
            valid_from), "\'{}\'".format(valid_to), modified_at, "\'{}\'".format(changed_by))
        database_processor.insert_data_into_database(sql_insert_statement)
        return 201
