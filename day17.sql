/*Day 17 (22/11): Subqueries (SELECT and FROM clause)
Subqueries in SELECT, derived tables, inline views*/
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT patient_id,
name,service, satisfaction,
(SELECT ROUND(AVG(satisfaction),2)
FROM patients p1 WHERE p1.service = p.service ) AS Avg_satisfaction
FROM patients p;
-- OR -- using window function
SELECT 
    patient_id,
    name,
    service,
    satisfaction,
    ROUND(AVG(satisfaction) OVER (PARTITION BY service), 2) 
        AS avg_service_satisfaction
FROM patients;

-- 2. Create a derived table of service statistics and query from it.
SELECT * 
FROM (
SELECT 
      service,
     SUM(patients_request) AS Total_patients_request,
     SUM(patients_admitted) AS Total_patients_admitted,
     SUM(patients_refused) AS Total_patients_refused,
     ROUND(AVG(patient_satisfaction),2) AS Avg_satisfaction
FROM services_weekly
GROUP BY service) AS service_stats
WHERE Total_patients_request>1000;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT * from staff;
Select * from patients;
	SELECT staff_id, staff_name,
	service, role,
	(SELECT COUNT(DISTINCT patient_id)
	FROM patients p
	WHERE p.service = s.service ) AS total_patients
	FROM staff s;
    
/* Question: Create a report showing each service with: service name, total patients admitted, the difference between
 their total admissions and the average admissions across all services, and a rank indicator ('Above Average',
 'Average', 'Below Average'). Order by total patients admitted descending. */
SELECT s.service,
s.Total_admitted,
a.Avg_Patient_admitted,
s.Total_admitted - a.Avg_Patient_admitted AS differnce,
CASE WHEN Total_admitted> Avg_Patient_admitted THEN 'Above Average'
     WHEN Total_admitted = Avg_Patient_admitted THEN 'Average'
     ELSE 'Below Average'
END AS Rank_indicator
FROM(
SELECT service,
       SUM(patients_admitted) AS Total_admitted
FROM services_weekly
GROUP BY service) s
CROSS JOIN
(SELECT	 ROUND(AVG(total_admitted),2) AS Avg_Patient_admitted  FROM
     (SELECT SUM(patients_admitted) AS total_admitted FROM services_weekly GROUP BY service)
AS x ) a
ORDER BY s.Total_admitted DESC ;