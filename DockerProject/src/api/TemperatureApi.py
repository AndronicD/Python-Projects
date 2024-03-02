from flask import Blueprint, request
from datetime import datetime
from helper import *

temperatures = Blueprint('Temperatures', __name__)

def verify_data(data):
    if verify_temperatures_fields(data) is True:
        return True
    return False
    
def verify_city_id(value):
    if verify_int(value):
        return True
    return False
    
def verify_country_id(value):
    if verify_int(value):
        return True
    return False
    
def verify_temperature_id(value):
    if verify_int(value):
        return True
    return False

def get_lat():
    return request.args.get('lat')
def get_lon():
    return request.args.get('lon')
def get_from():
    return datetime.strptime(request.args.get('from', default='1000-01-01', type=str),'%Y-%m-%d').strftime('%Y-%m-%d')
def get_until():
    return datetime.strptime(request.args.get('until', default='9999-12-31', type=str),'%Y-%m-%d').strftime('%Y-%m-%d')

@temperatures.route('/api/temperatures', methods=['POST'])
def post_request_temperature():
    data = request.get_json()
    if not verify_data(data):
        return generate_json_response({'error': 'Bad request'}, 400)
    column_names = ['city_id', 'temperature_value', 'timestamp']
    data_values = (data.get('idOras'), data.get('valoare'))
    return post_request('Temperatures', column_names, data_values)


@temperatures.route('/api/temperatures', methods=['GET'])
def get_temperatures():
    lat = get_lat()
    lon = get_lon()
    from_arg = get_from()
    until_arg = get_until()

    rest_of_the_query =  ' AND city_id in (SELECT id FROM Cities WHERE '
    if lat:
        if lon:
            rest_of_the_query += f' ROUND(latitude, 3) = {lat} AND ROUND(longitude, 3) = {lon})'
        else:
            rest_of_the_query += f' ROUND(latitude, 3) = {lat})'
    elif lon:
        rest_of_the_query += f' ROUND(longitude, 3) = {lon})'
    else:
        rest_of_the_query = ''

    query = f"SELECT id, temperature_value AS valoare, DATE_FORMAT(timestamp, '%Y-%m-%d') AS timestamp FROM Temperatures WHERE timestamp BETWEEN '{from_arg}' AND '{until_arg}' {rest_of_the_query}"
    column_names = ['id', 'valoare', 'timestamp']
    cursor.execute(query)
    data_list = [dict(zip(column_names, row)) for row in cursor.fetchall()]
    return generate_json_response(data_list, 200)

    
@temperatures.route('/api/temperatures/cities/<int:city_id>', methods=['GET'])
def get_temperatures_by_city(city_id):
    if not verify_city_id(city_id):
        return generate_json_response({'Mesaj': 'Not found'}, 200)
    from_arg = get_from()
    until_arg = get_until()

    query = f"SELECT id, temperature_value AS valoare, DATE_FORMAT(timestamp, '%Y-%m-%d') AS timestamp FROM Temperatures WHERE timestamp BETWEEN '{from_arg}' AND '{until_arg}' AND (city_id = {city_id})"
    column_names = ['id', 'valoare', 'timestamp']
    cursor.execute(query)
    data_list = [dict(zip(column_names, row)) for row in cursor.fetchall()]
    return generate_json_response(data_list, 200)

@temperatures.route('/api/temperatures/countries/<int:country_id>', methods=['GET'])
def get_temperatures_by_country(country_id):
    if not verify_city_id(country_id):
        return generate_json_response({'Mesaj': 'Not found'}, 200)
    from_arg = get_from()
    until_arg = get_until()

    query = f"SELECT id, temperature_value AS valoare, DATE_FORMAT(timestamp, '%Y-%m-%d') AS timestamp FROM Temperatures WHERE timestamp BETWEEN '{from_arg}' AND '{until_arg}' AND city_id IN (SELECT id FROM Cities WHERE country_id = {country_id})"
    column_names = ['id', 'valoare', 'timestamp']
    cursor.execute(query)
    data_list = [dict(zip(column_names, row)) for row in cursor.fetchall()]
    return generate_json_response(data_list, 200)

@temperatures.route('/api/temperatures/<int:temperature_id>', methods=['PUT'])
def put_request_temperature(temperature_id):
    data = request.get_json()
    if not verify_temperature_id(temperature_id):
        return generate_json_response({'Eroare': 'Not Found'}, 404)
    if not verify_data(data):
        return generate_json_response({'Eroare': 'Bad request'}, 400)
    column_names = ['city_id', 'temperature_value']
    data_values = [data.get('idOras'), data.get('valoare')]
    return put_request('Temperatures', 'id', temperature_id, column_names, data_values)


@temperatures.route('/api/temperatures/<int:temperature_id>', methods=['DELETE'])
def delete_request_temperature(temperature_id):
    if not verify_temperature_id(temperature_id):
        return generate_json_response({'Eroare': 'Bad Request'}, 400)
    return delete_request('Temperatures', 'id', temperature_id)