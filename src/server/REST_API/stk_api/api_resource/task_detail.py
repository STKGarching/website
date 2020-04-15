from flask_restful import Resource
from utils import file_processor, database_processor
from flask_restful import reqparse

class TaskDetail(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('task_no', required=True,
                            help="task_no cannot be blank!")
        args = parser.parse_args()
        QUERY_SELECT_TASK_DETAIL = file_processor.read_sql_file(
            "sql/select_task_details.sql")
        sql_task_detail = QUERY_SELECT_TASK_DETAIL.format(args['task_no'])
        task_detail = database_processor.fetch_data_in_database(
            sql_task_detail)
        column = ['relationship_type', 'person_no', 'first_name', 'last_name']
        items = [dict(zip(column, row)) for row in task_detail]
        return items