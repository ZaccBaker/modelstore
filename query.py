def customerQuery():
    
    query = """
    SELECT customer.customer_firstName, customer.customer_lastName
    FROM customer
    """

    return query
