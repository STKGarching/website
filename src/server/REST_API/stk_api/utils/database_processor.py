import psycopg2
import yaml
import os.path 

with open(os.path.dirname(__file__) + '/../../../../../config.yaml') as file:
    credentials = yaml.load(file,Loader=yaml.FullLoader)

connection = psycopg2.connect(host="localhost",database="stkgarching", user=credentials["database"]["username"], password=credentials["database"]["password"])
def fetch_data_in_database(sql):
    cursor = connection.cursor()
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def insert_data_into_database(sql):    
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()

  