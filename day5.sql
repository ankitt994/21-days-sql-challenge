/* Day 5 (07/11): Aggregate Functions (COUNT, SUM, AVG, MIN, MAX) COUNT, SUM, AVG, MIN, MAX functions
Practice Questions:
1. Count the total number of patients in the hospital.*/
SELECT COUNT(name) as total_no_patients
FROM patients;

/*2. Calculate the average satisfaction score of all patients.*/
SELECT AVG(satisfaction) FROM patients;

/*3. Find the minimum and maximum age of patients.*/
SELECT MIN(age), MAX(age)
 FROM patients;

/*Daily Challenge:
**Question:** Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks.
 Round the average satisfaction to 2 decimal places.*/
SELECT SUM(patients_admitted) as total_no_admitted_patients, SUM(patients_refused) as total_no_refused_patients, 
ROUND(AVG(patient_satisfaction), 2) as avg_patient_satisfaction
FROM services_weekly;









 
 
 
 
 
 