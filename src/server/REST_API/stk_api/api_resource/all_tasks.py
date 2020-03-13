
from flask_restful import Resource, Api
from flask import request
from utils import file_processor
from utils import database_processor

class GetAllTasks(Resource):
    def get(self):       
        QUERY_SELECT_ALL_TASKS = file_processor.read_sql_file("sql/select_all_tasks.sql")
        sql_all_tasks = QUERY_SELECT_ALL_TASKS
        all_tasks = database_processor.fetch_data_in_database(sql_all_tasks)
        column = ['task_no', 'title', 'description', 'created_at', 'modified_at', 'due_date', 'resolution_date', 'priority', 'task_status']
        items = [dict(zip(column, row)) for row in all_tasks]
        return items