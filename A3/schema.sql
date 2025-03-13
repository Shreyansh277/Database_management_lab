-- Schema creation
CREATE TABLE citizens (
    citizen_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    gender TEXT CHECK (gender IN ('Male', 'Female', 'Other')),
    dob DATE NOT NULL,
    household_id INT,
    educational_qualification TEXT,
    FOREIGN KEY (household_id) REFERENCES households(household_id)
);

CREATE TABLE households (
    household_id INT PRIMARY KEY,
    address TEXT NOT NULL,
    income DECIMAL(10, 2) NOT NULL
);

CREATE TABLE land_records (
    land_id INT PRIMARY KEY,
    citizen_id INT,
    area_acres DECIMAL(5, 2) NOT NULL,
    crop_type TEXT,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id)
);

CREATE TABLE panchayat_employees (
    employee_id INT PRIMARY KEY,
    citizen_id INT,
    role TEXT NOT NULL,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id)
);

CREATE TABLE assets (
    asset_id INT PRIMARY KEY,
    type TEXT,
    location TEXT,
    installation_date DATE
);

CREATE TABLE welfare_schemes (
    scheme_id INT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
);

CREATE TABLE scheme_enrollments (
    enrollment_id INT PRIMARY KEY,
    citizen_id INT,
    scheme_id INT,
    enrollment_date DATE,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id),
    FOREIGN KEY (scheme_id) REFERENCES welfare_schemes(scheme_id)
);

CREATE TABLE vaccinations (
    vaccination_id INT PRIMARY KEY,
    citizen_id INT,
    vaccine_type TEXT,
    date_administered DATE,
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id)
);

CREATE TABLE census_data (
    household_id INT,
    citizen_id INT,
    event_type TEXT CHECK (event_type IN ('Birth', 'Death', 'Marriage', 'Divorce')),
    event_date DATE,
    FOREIGN KEY (household_id) REFERENCES households(household_id),
    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id)
);
