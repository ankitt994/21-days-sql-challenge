/*Day 6 (09/11): GROUP BY Clause
**Topics:** GROUP BY, aggregating by categories*/
### Practice Questions:
/*1. Count the number of patients by each service.*/
SELECT service, COUNT(*) Total_no_patient FROM patients
GROUP BY service;

/*2. Calculate the average age of patients grouped by service.*/
SELECT service, AVG(age) as avg_age
FROM patients
GROUP BY service;

/*3. Find the total number of staff members per role.*/
SELECT role, COUNT(*) Total_no_staff FROM staff
GROUP BY role;

/*Daily Challenge:
**Question:** For each hospital service, calculate the total number of patients admitted, total patients refused, and
 the admission rate (percentage of requests that were admitted). Order by admission rate descending.*/
SELECT service, SUM(patients_admitted) as total_no_admitted, SUM(patients_refused) as total_no_refused, 
ROUND((SUM(patients_admitted)*100/SUM(patients_request)), 2) as admission_rate 
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;





