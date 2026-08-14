CREATE DATABASE IF NOT EXISTS CrossDataHosts;
USE CrossDataHosts;

CREATE TABLE IF NOT EXISTS property (
    property_type_id INT PRIMARY KEY,
    property_type_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS locations (
    location_id INT PRIMARY KEY,
    country VARCHAR(255),
    state VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS listing (
    listing_id INT PRIMARY KEY,
    detail VARCHAR(255),
    property_type_id INT,
    location_id INT,
    number_of_bed VARCHAR(255),
    price FLOAT,
    rating_value FLOAT,
    amount_of_answers INT,
    host_id INT,
    FOREIGN KEY (property_type_id) REFERENCES property(property_type_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE IF NOT EXISTS offers (
    offer_id INT PRIMARY KEY,
    listing_id INT,
    check_in VARCHAR(255),
    check_out VARCHAR(255),
    price FLOAT,
    offer_price FLOAT,
    FOREIGN KEY (listing_id) REFERENCES listing(listing_id)
)

