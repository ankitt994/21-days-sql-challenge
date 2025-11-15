/*Day 13 (17/11): INNER JOIN Topics: INNER JOIN, joining two tables, relationship understanding
Practice Questions: 1. Join patients and staff based on their common service field (show patient and staff who work in same service).*/
SELECT p.name, s.staff_name
FROM patients as p
INNER JOIN staff as s ON p.service = s.service;

/*2. Join services_weekly with staff to show weekly service data with staff information.*/
SELECT sw.week, sw.month, sw.service, sw.available_beds, sw.patients_request, sw.patients_admitted, 
sw.patients_refused, sw.patient_satisfaction, sw.staff_morale, sw.event, s.staff_id, s.staff_name, s.role
FROM services_weekly as sw
INNER JOIN staff as s ON sw.service = s.service;

SELECT * FROM patients;
SELECT * FROM staff;


/*3. Create a report showing patient information along with staff assigned to their service.*/
 SELECT p.patient_id, p.name, p.age, p.arrival_date, p.departure_date, p.service, p.satisfaction, s.staff_id, s.staff_name, s.role
FROM patients as p
INNER JOIN staff as s ON p.service = s.service;

/*Daily Challenge:
**Question:** Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service. 
Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name.*/
SELECT p.patient_id, p.name, p.age, p.service,
  COUNT(DISTINCT s.staff_id) AS staff_member_count
FROM patients AS p
JOIN staff    AS s ON p.service = s.service
GROUP BY p.patient_id, p.name, p.age, p.service
HAVING COUNT(DISTINCT s.staff_id) > 5
ORDER BY staff_member_count DESC, p.name;

