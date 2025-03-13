
-- A. Citizens who hold more than 1 acre of land
SELECT name FROM citizens c
JOIN land_records lr ON c.citizen_id = lr.citizen_id
WHERE lr.area_acres > 1;

-- B. Girls studying in school with household income < 1 Lakh/year
SELECT name FROM citizens c
JOIN households h ON c.household_id = h.household_id
WHERE c.gender = 'Female' AND c.educational_qualification IN ('Primary', '10th', '12th') AND h.income < 100000;

-- C. Total acres of land cultivating rice
SELECT SUM(area_acres) AS total_rice_acres FROM land_records WHERE crop_type = 'Rice';

-- D. Citizens born after 1.1.2000 with educational qualification of 10th class
SELECT COUNT(*) AS count FROM citizens WHERE dob > '2000-01-01' AND educational_qualification = '10th';

-- E. Employees of panchayat who hold more than 1 acre of land
SELECT name FROM citizens c
JOIN panchayat_employees pe ON c.citizen_id = pe.citizen_id
JOIN land_records lr ON c.citizen_id = lr.citizen_id
WHERE lr.area_acres > 1;

-- F. Household members of Panchayat Pradhan
SELECT name FROM citizens WHERE household_id = (SELECT household_id FROM citizens c JOIN panchayat_employees pe ON c.citizen_id = pe.citizen_id WHERE pe.role = 'Pradhan');

-- G. Total street light assets in Phulera installed in 2024
SELECT COUNT(*) AS total_assets FROM assets WHERE location = 'Phulera' AND type = 'Street Light' AND installation_date BETWEEN '2024-01-01' AND '2024-12-31';

-- H. Number of vaccinations in 2024 for children with class 10 qualification
SELECT COUNT(*) AS total_vaccinations FROM vaccinations v
JOIN citizens c ON v.citizen_id = c.citizen_id
WHERE v.date_administered BETWEEN '2024-01-01' AND '2024-12-31' AND c.educational_qualification = '10th';

-- I. Total boy births in 2024
SELECT COUNT(*) AS boy_births FROM census_data cd
JOIN citizens c ON cd.citizen_id = c.citizen_id
WHERE cd.event_type = 'Birth' AND c.gender = 'Male' AND cd.event_date BETWEEN '2024-01-01' AND '2024-12-31';

-- J. Number of citizens from households with at least one panchayat employee
SELECT COUNT(DISTINCT c.citizen_id) AS total_citizens FROM citizens c
WHERE c.household_id IN (SELECT DISTINCT household_id FROM citizens c2
JOIN panchayat_employees pe ON c2.citizen_id = pe.citizen_id);
