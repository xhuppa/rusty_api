-- User table
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
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
    user_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Service Provider Type table
CREATE TABLE service_provider_type (
    service_provider_type_id INT PRIMARY KEY AUTO_INCREMENT,
    service_provider_name VARCHAR(255) NOT NULL
);

-- Vendor table
CREATE TABLE vendor (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    pricing DECIMAL(10, 2),
    description TEXT
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Venue table
CREATE TABLE venue (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    location_id INT,
);
-- Venue pricing table
CREATE TABLE venue_prices (
    price_id INT PRIMARY KEY AUTO_INCREMENT,
    day_of_week VARCHAR(255),
    price_amount INT,
    FOREIGN KEY (venue_id) REFERENCES venue_location(venue_id)
);
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255),
);
CREATE TABLE bar_service (
    bar_service_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT,
    category_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id)
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
    FOREIGN KEY (service_provider_type_id) REFERENCES service_provider_type(service_provider_type_id) -- Reference to service provider type
);

CREATE TABLE music (
    music_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT,
    category_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id)
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
    FOREIGN KEY (service_provider_type_id) REFERENCES service_provider_type(service_provider_type_id) -- Reference to service provider type
);

CREATE TABLE music_prices (
    music_price_id INT PRIMARY KEY AUTO_INCREMENT,
    music_id INT,
    fixed_rate INT,
    price_per_hour DECIMAL(10, 2),
    -- Add other attributes related to pricing (e.g., effective_date, discounts)
    FOREIGN KEY (music_id) REFERENCES music(music_id)
);

-- Create Bar_Service_Prices table for price based on expected number of people
CREATE TABLE bar_service_prices (
    bar_service_price_id INT PRIMARY KEY AUTO_INCREMENT,
    bar_service_id INT,
    expected_people INT,
    price_based_on_people DECIMAL(10, 2),
    -- Add other attributes related to pricing (e.g., effective_date, discounts)
    FOREIGN KEY (bar_service_id) REFERENCES bar_service(bar_service_id)
);
