from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse
from flask import request

class AddCourt(Resource):
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
        QUERY_INSERT_COURT = file_processor.read_sql_file(
            "sql/insert_court.sql")
        sql_insert_court = QUERY_INSERT_COURT.format(court_id, court_no, "\'{}\'".format(court_surface), "\'{}\'".format(
            court_type), "\'{}\'".format(valid_from), "\'{}\'".format(valid_to), modified_at, "\'{}\'".format(changed_by))
        database_processor.insert_data_into_database(sql_insert_court)
        return 201