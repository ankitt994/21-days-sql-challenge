/*Day 18 (24/11): UNION and UNION ALL
Topics:** UNION, UNION ALL, combining result sets
Practice Questions:
1. Combine patient names and staff names into a single list.*/
SELECT name AS combined_name FROM patients 
UNION ALL
SELECT staff_name AS combined_name FROM staff;

/*2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).*/
SELECT patient_id, name, age, service, satisfaction, 'high satisfaction' as Satisfaction_level
FROM patients
WHERE satisfaction > 90
UNION
SELECT patient_id, name, age, service, satisfaction, 'low satisfaction' as Satisfaction_level
FROM patients
WHERE satisfaction < 50;

/*3. List all unique names from both patients and staff tables.*/
SELECT name AS unique_name FROM patients 
UNION 
SELECT staff_name AS unique_name FROM staff;


/*Daily Challenge:
**Question:** Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), and associated service.
  Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.*/
  SELECT patient_id as identifier,
  name as names, 'Patient' AS type, service
FROM patients
  WHERE service IN( 'surgery', 'emergency')
  UNION ALL
  SELECT staff_id as identifier, staff_name as names, 'Staff' AS type, service
FROM staff
   WHERE service IN( 'surgery', 'emergency')
   ORDER BY type, service, names;

  
  
  
  
  
  
  