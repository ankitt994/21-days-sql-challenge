/*Day 9 (12/11): Date Functions Practice Questions:
 1. Extract the year from all patient arrival dates.*/
 SELECT YEAR(arrival_date) as arrival_year FROM patients;
 
/*2. Calculate the length of stay for each patient (departure_date - arrival_date).*/
SELECT name, DATEDIFF(departure_date,arrival_date) FROM patients;

/*3. Find all patients who arrived in a specific month.*/
SELECT name, MONTH(arrival_date) FROM patients;

/*Daily Challenge:
**Question:** Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending.*/
SELECT COUNT(patient_id) as total_patient, AVG(DATEDIFF(departure_date,arrival_date)) as length_of_stay
 FROM patients
 GROUP BY service
 HAVING AVG(DATEDIFF(departure_date,arrival_date)) >7
 ORDER BY length_of_stay DESC;
