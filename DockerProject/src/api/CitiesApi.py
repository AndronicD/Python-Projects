from flask import Blueprint, request
from helper import *

cities = Blueprint('Cities', __name__)

def verify_data(data):
    if verify_cities_fields(data) is True:
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

@cities.route('/api/cities', methods=['POST'])
def post_request_city():
    data = request.get_json()
    if not verify_data(data):
        return generate_json_response({'Eroare': 'Bad Request'}, 400)
    column_names = ['country_id', 'city_name', 'latitude', 'longitude']
    data_values = (data.get('idTara'), data.get('nume'), data.get('lat'), data.get('lon'))
    return post_request('Cities', column_names, data_values)

@cities.route('/api/cities', methods=['GET'])
def get_request_city():
    query = "SELECT id, country_id, city_name, latitude, longitude FROM Cities;"
    column_names = ['id', 'idTara', 'nume', 'lat', 'lon']
    return get_request(query, column_names)

@cities.route('/api/cities/country/<int:country_id>', methods=['GET'])
def get_cities_by_country(country_id):
    if not verify_country_id(country_id):
        return generate_json_response({'[]'}, 200)
    query = "SELECT id, country_id, city_name, latitude, longitude FROM Cities WHERE country_id=%s;"
    column_names = ['id', 'idTara', 'nume', 'lat', 'lon']
    cursor.execute(query, (country_id,))
    data_list = [dict(zip(column_names, row)) for row in cursor.fetchall()]
    return generate_json_response(data_list, 200)

@cities.route('/api/cities/<int:city_id>', methods=['PUT'])
def put_request_city(city_id):
    data = request.get_json()
    if not verify_city_id(city_id):
        return generate_json_response({'Eroare': 'Not Found'}, 404)
    if not verify_data(data):
        return generate_json_response({'Eroare': 'Bad request'}, 400)
    column_names = ['country_id', 'city_name', 'latitude', 'longitude']
    data_values = [data.get('id_tara'), data.get('nume'), data.get('lat'), data.get('lon')]
    return put_request('Cities', 'id', city_id, column_names, data_values)

@cities.route('/api/cities/<int:city_id>', methods=['DELETE'])
def delete_request_city(city_id):
    if not verify_city_id(city_id):
        return generate_json_response({'Eroare': 'Bad Request'}, 400)
    return delete_request('Cities', 'id', city_id)