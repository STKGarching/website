import psycopg2

connection = psycopg2.connect(host="localhost",database="stkgarching", user="admin", password="admin")
def fetch_data_in_database(sql):
    #connection = mysql.connect()
    cursor = connection.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def insert_data_into_database(sql):    
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()

  