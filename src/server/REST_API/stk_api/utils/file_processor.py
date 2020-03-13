def read_sql_file(input_file):
    sql_statement = ""
    with open(input_file, 'r') as file:
        sql_statement = file.read().replace('\n', ' ')

    return sql_statement 