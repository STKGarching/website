from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class GetTaskComments(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('task_no', required=True,
                            help="task_no cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT = file_processor.read_sql_file(
            "sql/task_details_comments.sql")
        sql_statement = QUERY_SELECT.format(args['task_no'])
        row_list = database_processor.fetch_data_in_database(sql_statement)
        column = ['relationship_type', 'title', 'comment', 'created_at',
                  'modified_at', 'person_no', 'first_name', 'last_name']
        items = [dict(zip(column, row)) for row in row_list]
        return items
