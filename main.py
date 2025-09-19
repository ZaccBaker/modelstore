import mysql.connector # to connect
from mysql.connector import errorcode
import dotenv # to use .env file
from dotenv import dotenv_values
from report import *

hidden = dotenv_values(".env")

""" database config object """
config = {
    "user": hidden["USER"],
    "password": hidden["PASSWORD"],
    "host": hidden["HOST"],
    "database": hidden["DATABASE"],
    "raise_on_warnings": True
}

try: 

    db = mysql.connector.connect(**config) 
    cursor = db.cursor()

    customerReportCurrentCustomers(cursor)



except mysql.connector.Error as err:

    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")

    else:
        print(err)

finally:

    db.close()