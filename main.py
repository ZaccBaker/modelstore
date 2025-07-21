import mysql.connector
from mysql.connector import errorcode

import dotenv
from dotenv import dotenv_values

#Import queries
# from control import flow

if __name__ == "__main__":
    hidden = dotenv_values(".env")

    config = {
        "user": hidden["USER"],
        "password": hidden["PASSWORD"],
        "host": hidden["HOST"],
        "database": hidden["DATABASE"],
        "raise_on_warnings": True
    }

    try:

        db = mysql.connector.connect(**config)

        ###Query input here
        # flow(db)


        #Testing to see if connection worked - this shows up, it works
        print("\n  Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))

        input("\n\n  Press any key to continue...")

    except mysql.connector.Error as err:
        """ on error code """

        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("  The supplied username or password are invalid")

        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("  The specified database does not exist")

        else:
            print(err)

    finally:
        """ close the connection to MySQL """

        db.close()