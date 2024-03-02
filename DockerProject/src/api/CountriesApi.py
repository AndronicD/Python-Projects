from flask import Blueprint, request
from helper import *

countries = Blueprint('Countries', __name__)

def verify_data(data):
    if verify_countries_fields(data) is True:
        return True
    return False
    
def verify_country_id(value):
    if verify_int(value):
        return True
    return False

@countries.route('/api/countries', methods=['POST'])
def post_request_country():
    data = request.get_json()
    if not verify_data(data):
        return generate_json_response({'Eroare': 'Bad request'}, 400)
    column_names = ['country_name', 'latitude', 'longitude']
    data_values = (data.get('nume'), data.get('lat'), data.get('lon'))
    return post_request('Countries', column_names, data_values)

@countries.route('/api/countries', methods=['GET'])
def get_request_country():
    query = "SELECT id, country_name, latitude, longitude FROM Countries;"
    column_names = ['id', 'nume', 'lat', 'lon']
    return get_request(query, column_names)

@countries.route('/api/countries/<int:country_id>', methods=['PUT'])
def put_request_country(country_id):
    data = request.get_json()
    if not verify_country_id(country_id):
        return generate_json_response({'Eroare': 'Not Found'}, 404)
    if not verify_data(data):
        return generate_json_response({'Erore': 'Bad request'}, 400)
    column_names = ['country_name', 'latitude', 'longitude']
    data_values = [data.get('nume'), data.get('lat'), data.get('lon')]
    return put_request('Countries', 'id', country_id, column_names, data_values)

@countries.route('/api/countries/<int:country_id>', methods=['DELETE'])
def delete_request_country(country_id):
    if not verify_country_id(country_id):
        return generate_json_response({'Eroare': 'Bad Request'}, 400)
    return delete_request('Countries', 'id', country_id)