-- User table
CREATE TABLE user (
    user_id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    user_type INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_type) REFERENCES user_type(user_type_id)
);

-- User Type table (Optional, for defining user roles)
CREATE TABLE user_type (
    user_type_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Host table
CREATE TABLE host (
    host_id INT PRIMARY KEY,
    name VARCHAR(255),
    address TEXT,
    pricing DECIMAL(10, 2),
    restrictions TEXT
);

-- Vendor table
CREATE TABLE vendor (
    vendor_id INT PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(255),
    pricing DECIMAL(10, 2),
    description TEXT
);

-- Event table
CREATE TABLE event (
    event_id INT PRIMARY KEY,
    name VARCHAR(255),
    date DATE,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES event_location(event_location_id)
);

-- Event Location table
CREATE TABLE event_location (
    event_location_id INT PRIMARY KEY,
    host_id INT,
    address TEXT,
    pricing DECIMAL(10, 2),
    restrictions TEXT
);

-- Event Location Links table (for associating multiple locations with an event)
CREATE TABLE event_location_links (
    event_location_id INT,
    event_id INT,
    FOREIGN KEY (event_location_id) REFERENCES event_location(event_location_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

-- Event Vendor table
CREATE TABLE event_vendor (
    event_vendor_id INT PRIMARY KEY,
    event_id INT,
    vendor_id INT,
    FOREIGN KEY (event_id) REFERENCES event(event_id),
    FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id)
);
