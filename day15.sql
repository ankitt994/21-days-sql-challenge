/*Day 15 (19/11): Multiple Joins Joining more than two tables, complex relationships
Practice Questions: 1. Join patients, staff, and staff_schedule to show patient service and staff availability.*/
 select p.patient_id,
        p.name as Patient_name,
        p.service,
        s.staff_name,
        ss.week,
        COUNT(DISTINCT s.staff_id) AS assigned_staff,
        ROUND(AVG(ss.present),2) AS avg_staff_present
 FROM patients p 
 LEFT join staff s ON p.service = s.service
 LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
 GROUP BY  p.patient_id, p.name, p.service,s.staff_name,ss.week;
 
 /*2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.*/
 SELECT sw.service,
        sw.week,
        sw.patients_admitted,
        sw.patients_refused,
        sw.patient_satisfaction
FROM services_weekly sw
JOIN staff s ON sw.service = s.service
JOIN staff_schedule ss ON ss.staff_id = s.staff_id And
                          ss.week = sw.week;
                          
/*3. Create a multi-table report showing patient admissions with staff information.*/
SELECT p.patient_id,
       p.name,
       sw.week,
       sw.patients_admitted,
       s.staff_name
FROM patients p 
LEFT JOIN services_weekly sw ON p.service = sw.service
LEFT JOIN staff s ON p.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id =ss.staff_id 
And sw.week = ss.week;

/* Challenge Question: Create a comprehensive service analysis report for week 20 showing: service name, total patients 
admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and
 count of staff present that week. Order by patients admitted descending. */
SELECT
      sw.service,
      SUM(sw.patients_admitted) AS total_patients_admitted,
      SUM(sw.patients_refused) AS total_patients_refused,
      ROUND(avg(sw.patient_satisfaction),2) avg_patient_satisfaction
FROM services_weekly sw
JOIN staff_schedule ss ON sw.service =ss.service 
                    AND sw.week =ss.week
WHERE sw.week = 20
GROUP BY sw.service
ORDER BY total_patients_admitted DESC ;


