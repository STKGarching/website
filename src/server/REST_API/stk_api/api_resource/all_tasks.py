from flask_restful import Resource
from utils import file_processor

class GetAllTasks(Resource):
    def __init__(self, **kwargs):        
        self.database_processor = kwargs['database_processor']

    def get(self):        
        QUERY_SELECT_ALL_TASKS = file_processor.read_sql_file(
            "sql/select_all_tasks.sql")
        sql_all_tasks = QUERY_SELECT_ALL_TASKS
        all_tasks = self.database_processor.fetch_data_in_database(sql_all_tasks)
        column = ['task_no', 'title', 'description', 'created_at', 'modified_at',
                  'due_date', 'resolution_date', 'priority', 'task_status']
        items = [dict(zip(column, row)) for row in all_tasks]
        return items