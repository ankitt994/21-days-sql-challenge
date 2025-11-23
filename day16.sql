# Day 16
 -- 1. Find patients who are in services with above-average staff count.
 SELECT * FROM patients
 WHERE service IN(
      SELECT service FROM staff 
       GROUP BY service
 HAVING count(staff_id)>
    (SELECT AVG(service_count) 
FROM(
 SELECT count(staff_id) AS service_count
 FROM staff
  GROUP BY service)t));
  
-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT * FROM staff
WHERE service IN (
   SELECT DISTINCT service
   FROM services_weekly
   WHERE patient_satisfaction<70);
   
-- 3. Show patients from services where total admitted patients exceed 1000.
select *
FROM patients
WHERE service IN(
    SELECT service
    FROM services_weekly 
    GROUP BY service
	HAVING sum(patients_admitted)>1000);
    
/* Question: Find all patients who were admitted to services that had at least one week where patients were refused
 AND the average patient satisfaction for that service was below the overall hospital average satisfaction. Show
 patient_id, name, service, and their personal satisfaction score. */
 SELECT 
    p.patient_id,p.name,
    p.service, p.satisfaction
FROM patients p
WHERE p.service IN (
    SELECT sw.service
    FROM services_weekly sw
    GROUP BY sw.service
    HAVING SUM(sw.patients_refused) > 0
           AND AVG(sw.patient_satisfaction) < (
            SELECT AVG(patient_satisfaction)
            FROM services_weekly ));