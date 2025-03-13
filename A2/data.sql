-- Insert sample data
INSERT INTO households VALUES 
    (1, 'Phulera', 90000), (2, 'Mohanpur', 120000), (3, 'Rampur', 150000), (4, 'Dhanpur', 85000), (5, 'Shivpur', 70000),
    (6, 'Ganeshpur', 60000), (7, 'Basantpur', 95000), (8, 'Lakshmipur', 110000), (9, 'Hanumanpur', 50000), (10, 'Radheypur', 80000);

INSERT INTO citizens VALUES 
    (1, 'Ramesh', 'Male', '1985-04-10', 1, 'Graduate'),
    (2, 'Sita', 'Female', '2010-03-15', 1, '10th'),
    (3, 'Geeta', 'Female', '2012-06-20', 1, 'Primary'),
    (4, 'Rajesh', 'Male', '2001-12-11', 2, '12th'),
    (5, 'Anita', 'Female', '1990-05-14', 3, 'Post-Graduate'),
    (6, 'Vikas', 'Male', '1995-07-19', 3, 'Graduate'),
    (7, 'Meena', 'Female', '2003-09-22', 4, '10th'),
    (8, 'Rohit', 'Male', '2005-11-11', 5, '12th'),
    (9, 'Kiran', 'Female', '1989-08-30', 5, 'Graduate'),
    (10, 'Sunita', 'Female', '1992-12-01', 4, 'Post-Graduate'),
    (11, 'Manoj', 'Male', '1984-07-19', 6, 'Graduate'),
    (12, 'Pooja', 'Female', '1993-05-14', 7, 'Post-Graduate'),
    (13, 'Amit', 'Male', '2000-08-21', 8, '12th'),
    (14, 'Neha', 'Female', '1996-11-09', 9, 'Graduate'),
    (15, 'Nikhil', 'Male', '1999-01-11', 10, '10th');

-- Add 50 dynamic citizens
DO $$
DECLARE 
    i INT := 16;
    genders TEXT[] := ARRAY['Male', 'Female'];
    quals TEXT[] := ARRAY['Illiterate', 'Primary', '10th', '12th', 'Graduate', 'Post-Graduate'];
BEGIN
    WHILE i <= 65 LOOP
        INSERT INTO citizens (citizen_id, name, gender, dob, household_id, educational_qualification)
        VALUES (i, 'Citizen_' || i, genders[1 + random() * 1], 
                '1980-01-01'::DATE + (random() * (365 * 40))::INT, 
                (1 + random() * 10)::INT, quals[1 + random() * 5]);
        i := i + 1;
    END LOOP;
END $$;

INSERT INTO land_records VALUES 
    (1, 1, 1.5, 'Rice'), (2, 4, 0.8, 'Wheat'), (3, 2, 1.2, 'Cotton'), (4, 5, 1.8, 'Rice'), (5, 3, 0.5, 'Wheat'),
    (6, 6, 2.0, 'Sugarcane'), (7, 7, 3.0, 'Rice'), (8, 8, 0.6, 'Wheat'), (9, 9, 1.2, 'Cotton'), (10, 10, 1.5, 'Maize');

INSERT INTO panchayat_employees VALUES 
    (1, 1, 'Pradhan'), (2, 4, 'Secretary'), (3, 6, 'Member'), (4, 5, 'Treasurer'), (5, 11, 'Accountant'), (6, 12, 'Clerk');

INSERT INTO assets VALUES 
    (1, 'Street Light', 'Phulera', '2024-01-10'),
    (2, 'Street Light', 'Phulera', '2024-02-12'),
    (3, 'Water Pump', 'Mohanpur', '2023-05-14'),
    (4, 'Road', 'Rampur', '2022-07-21'),
    (5, 'Street Light', 'Ganeshpur', '2024-03-15'),
    (6, 'Water Tank', 'Shivpur', '2021-11-05');

INSERT INTO welfare_schemes VALUES 
    (1, 'Scholarship', 'Support for school children'),
    (2, 'Health Insurance', 'Medical assistance for families'),
    (3, 'Crop Subsidy', 'Support for farmers'),
    (4, 'Old Age Pension', 'Support for senior citizens'),
    (5, 'Employment Guarantee', 'Job creation program');

INSERT INTO scheme_enrollments VALUES 
    (1, 2, 1, '2024-01-01'),
    (2, 5, 2, '2023-03-12'),
    (3, 4, 3, '2022-11-20'),
    (4, 8, 1, '2024-02-15'),
    (5, 13, 5, '2024-04-01'),
    (6, 14, 4, '2023-12-11');

INSERT INTO vaccinations VALUES 
    (1, 2, 'Polio', '2024-03-01'),
    (2, 3, 'Covid-19', '2024-04-10'),
    (3, 6, 'Hepatitis', '2023-05-15'),
    (4, 9, 'Polio', '2024-01-25'),
    (5, 13, 'Polio', '2024-02-11'),
    (6, 14, 'Covid-19', '2024-03-22');

INSERT INTO census_data VALUES 
    (1, 3, 'Birth', '2024-04-01'),
    (2, 7, 'Birth', '2024-05-20'),
    (3, 10, 'Birth', '2024-06-10'),
    (4, 8, 'Death', '2023-09-15'),
    (5, 15, 'Marriage', '2024-07-05'),
    (6, 11, 'Birth', '2024-08-12');
