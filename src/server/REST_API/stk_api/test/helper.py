import sqlite3

class Helper:
    def create_test_db(self):
        db = sqlite3.connect("sqlite:///")
        cur = db.cursor()
        #for statement in TEST_DATABASE_STATEMENTS:
        #    cur.execute(statement)
        

