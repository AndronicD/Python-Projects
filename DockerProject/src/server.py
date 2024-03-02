from flask import Flask
from api.TemperatureApi import temperatures
from api.CountriesApi import countries
from api.CitiesApi import cities

server = Flask(__name__)

server.register_blueprint(temperatures)
server.register_blueprint(countries)
server.register_blueprint(cities)

if __name__ == "__main__":
	server.run('0.0.0.0',port=6000,debug=False)