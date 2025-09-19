from query import *

def customerReportCurrentCustomers(cursor): #Report for current customers

    print("Customer Report - Current Customers")
    
    cursor.execute(customerQuery())
    rows = cursor.fetchall()

    for person in rows:
        print(f"\t{person[1]}, {person[0]}")

