-- User Type table (Optional, for defining user roles)
CREATE TABLE user_type (
    user_type_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
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

-- Service Provider Type table
CREATE TABLE service_provider_type (
    service_provider_type_id INT PRIMARY KEY,
    service_provider_name VARCHAR(255) NOT NULL
);
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

-- Vendor table
CREATE TABLE vendor (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(255),
    vendor_pricing DECIMAL(10, 2),
    vendor_description TEXT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Venue table
CREATE TABLE venue (
    venue_id INT PRIMARY KEY,
    name VARCHAR(255),
    location_id INT
);

-- Venue pricing table
CREATE TABLE venue_prices (
    price_id INT PRIMARY KEY,
    day_of_week VARCHAR(255),
    price_amount INT,
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES venue(venue_id)
);

CREATE TABLE bar_service (
    bar_service_id INT PRIMARY KEY,
    vendor_id INT,
    category_id INT,
    service_provider_type_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (service_provider_type_id) REFERENCES service_provider_type(service_provider_type_id) -- Reference to service provider type
);

CREATE TABLE music (
    music_id INT PRIMARY KEY,
    vendor_id INT,
    category_id INT,
    service_provider_type_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (service_provider_type_id) REFERENCES service_provider_type(service_provider_type_id) -- Reference to service provider type
);

CREATE TABLE music_prices (
    music_price_id INT PRIMARY KEY,
    music_id INT,
    fixed_rate INT,
    price_per_hour DECIMAL(10, 2),
    -- Add other attributes related to pricing (e.g., effective_date, discounts)
    FOREIGN KEY (music_id) REFERENCES music(music_id)
);

-- Create Bar_Service_Prices table for price based on expected number of people
CREATE TABLE bar_service_prices (
    bar_service_price_id INT PRIMARY KEY,
    bar_service_id INT,
    expected_people INT,
    price_based_on_people DECIMAL(10, 2),
    -- Add other attributes related to pricing (e.g., effective_date, discounts)
    FOREIGN KEY (bar_service_id) REFERENCES bar_service(bar_service_id)
);
