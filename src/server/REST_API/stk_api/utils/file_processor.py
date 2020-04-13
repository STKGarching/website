import os

def read_sql_file(input_file):
    sql_statement = ""
    api_path = str(os.getcwd())
    if "stk_api" not in api_path:
        api_path = api_path + "/stk_apif/"

    with open(str(os.getcwd()) + "/" + input_file, 'r') as file:
        sql_statement = file.read().replace('\n', ' ')

    return sql_statement 
