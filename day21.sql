/*Day 21 (27/11): Common Table Expressions (CTEs)
**Topics:** WITH clause, CTEs, recursive CTEs (if applicable), query organization
### Practice Questions:
1. Create a CTE to calculate service statistics, then query from it.*/
WITH service_stats AS (
    SELECT 
        service,
        SUM(patients_admitted) AS total_admitted,
        SUM(patients_refused) AS total_refused,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM hospital.services_weekly
    GROUP BY service
)
SELECT *
FROM service_stats;
/*2. Use multiple CTEs to break down a complex query into logical steps.*/
WITH cte_satisfaction AS (-- Step 1: Avg satisfaction per service
    SELECT service, AVG(satisfaction) AS avg_satisfaction FROM patients
    GROUP BY service),
cte_admissions AS (-- Step 2: Total admitted patients per service
    SELECT service, SUM(patients_admitted) AS total_admitted FROM services_weekly
    GROUP BY service),
cte_morale AS (-- Step 3: Avg staff morale per service
    SELECT service, AVG(staff_morale) AS avg_morale FROM services_weekly
    GROUP BY service)
-- Final Step: Join all CTEs and filter
   SELECT s.service, s.avg_satisfaction, a.total_admitted, m.avg_morale
FROM cte_satisfaction s
JOIN cte_admissions a USING (service)
JOIN cte_morale m USING (service)
WHERE s.avg_satisfaction >= 4
  AND m.avg_morale >= 70
ORDER BY s.avg_satisfaction DESC;

/*3. Build a CTE for staff utilization and join it with patient data.*/
WITH cte_staff_util AS (
    SELECT 
        service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service)
SELECT p.patient_id,
    p.name AS patient_name, p.age, p.arrival_date, p.departure_date, p.service, p.satisfaction, u.total_staff
FROM patients p
JOIN cte_staff_util u
    ON p.service = u.service
ORDER BY p.service, p.patient_id;


/*Daily Challenge:
**Question:** Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction), 2) 
Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report 
showing service name, all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.*/
WITH  cte_service AS (SELECT service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        AVG(patient_satisfaction) AS avg_satisfaction,
        SUM(patients_admitted) / NULLIF(SUM(patients_request), 0) AS admission_rate
    FROM services_weekly
    GROUP BY service),  -- 2STAFF METRICS PER SERVICE 
cte_staff AS (SELECT service,
        COUNT(*) AS total_staff
    FROM staff
    GROUP BY service),   -- 3️PATIENT DEMOGRAPHICS PER SERVICE 
cte_patient AS (SELECT service,
        COUNT(*) AS patient_count,
        AVG(age) AS avg_age
    FROM patients
    GROUP BY service)    -- 4️FINAL PERFORMANCE DASHBOARD
SELECT s.service,
    s.total_admissions,
    s.total_refusals,
    ROUND(s.avg_satisfaction, 2) AS avg_satisfaction,
    ROUND(s.admission_rate, 2) AS admission_rate,
    st.total_staff,
    p.patient_count, ROUND(p.avg_age, 1) AS avg_patient_age,  -- PERFORMANCE SCORE (50% satisfaction + 50% admission rate)
    ROUND((0.5 * s.avg_satisfaction) + (0.5 * (s.admission_rate * 100)), 2) AS performance_score
FROM cte_service s
LEFT JOIN cte_staff st USING (service)
LEFT JOIN cte_patient p USING (service)
ORDER BY performance_score DESC;





