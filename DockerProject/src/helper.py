import MySQLdb
from flask import json
import yaml
import time

with open('config.yaml', 'r') as file:
    config = yaml.safe_load(file)

db_user = config.get('MY_DATABASE_USER', 'root')
db_password = config.get('MY_DATABASE_PASSWORD', 'password')
db_host = config.get('MY_DATABASE_HOST', 'database')
db_port = config.get('MY_DATABASE_PORT', '3306')
db_name = config.get('MY_DATABASE_NAME', 'BD_Meteo_Info')

while True:
    try:
        conn = MySQLdb.connect(
            user=db_user,
            passwd=db_password,
            host=db_host,
            port=int(db_port),
            database=db_name
        )
        try:
            cursor = conn.cursor()
            print("Success cursor")
        except Exception:
            print("Fail cursor")
        print("Success database connection")
        break
    except Exception:
        print("Wait")
        time.sleep(3)

def generate_json_response(data, status_code, headers=None):
    response_body = json.dumps(data) if data else []
    response_headers = {'Content-Type': 'application/json'}
    
    if headers:
        response_headers.update(headers)

    return response_body, status_code, response_headers

def get_request(query, column_names):
    cursor.execute(query)
    data_list = [dict(zip(column_names, row)) for row in cursor.fetchall()]
    return generate_json_response(data_list, 200)

def post_request(table_name, column_names, data_values):
    try:
        placeholders = ', '.join(['%s' for _ in data_values])
        if(table_name == 'Temperatures'):
            placeholders += ', NOW(6)'
        columns = ', '.join(column_names)
        query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders});"
        cursor.execute(query, data_values)
        conn.commit()
    except:
        return generate_json_response({'Eroare': 'Conflict Response'}, 409)

    cursor.execute("SELECT LAST_INSERT_ID();")
    last_inserted_id = cursor.fetchone()[0]
    return generate_json_response({'id': last_inserted_id}, 201)

def put_request(table_name, id_column_name, id_value, column_names, data_values):
    try:
        set_clause = ', '.join([f"{col} = %s" for col in column_names])
        if(table_name == 'Temperatures'):
            set_clause += ", timestamp = NOW(6)"
        query = f"UPDATE {table_name} SET {set_clause} WHERE {id_column_name} = %s;"
        cursor.execute(query, data_values + [id_value])
        conn.commit()
    except:
        return generate_json_response({'Eroare': 'Conflict Response'}, 409)

    return generate_json_response('', 200)

def delete_request(table_name, id_column_name, id_value):
    try:
        cursor.execute(f"SELECT * FROM {table_name} WHERE {id_column_name} = %s;", (id_value,))
        existing_data = cursor.fetchone()
        if not existing_data:
            return generate_json_response({'Eroare': f'{table_name.capitalize()} not found'}, 404)
        cursor.execute(f"DELETE FROM {table_name} WHERE {id_column_name} = %s;", (id_value,))
    except:
        return generate_json_response({'Eroare': 'Conflict Response'}, 409)

    conn.commit()
    return generate_json_response('', 200)


def verify_cities_fields(data):
    nume = data.get('nume')
    latitudine = data.get('lat')
    longitudine = data.get('lon')
    idTara = data.get('idTara')

    if nume is None or latitudine is None or longitudine is None or idTara is None:
        return False
    else:
        return True
    
def verify_countries_fields(data):
    nume = data.get('nume')
    latitudine = data.get('lat')
    longitudine = data.get('lon')

    if nume is None or latitudine is None or longitudine is None:
        return False
    else:
        return True
    
def verify_temperatures_fields(data):
    idOras = data.get('idOras')
    valoare = data.get('valoare')

    if valoare is None or idOras is None:
        return False
    else:
        return True
    
def verify_int(value):
    if isinstance(value, int):
        return True
    elif isinstance(value, str) and value.isdigit():
        return True
    else:
        return False


