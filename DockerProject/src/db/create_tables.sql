CREATE DATABASE IF NOT EXISTS BD_Meteo_Info;
USE BD_Meteo_Info;

CREATE TABLE Countries (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) UNIQUE NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL
);

CREATE TABLE Cities (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    city_name VARCHAR(255) NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    UNIQUE(country_id, city_name),
    FOREIGN KEY (country_id) REFERENCES Countries(id)
);

CREATE TABLE Temperatures (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    temperature_value FLOAT NOT NULL,
    timestamp TIMESTAMP(6),
    city_id INT NOT NULL,
    UNIQUE(city_id, timestamp),
    FOREIGN KEY (city_id) REFERENCES Cities(id)
);
