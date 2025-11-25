/*Day 19 (25/11): Window Functions - ROW_NUMBER, RANK, DENSE_RANK
Topics: ROW_NUMBER(), RANK(), DENSE_RANK(), OVER clause
### Practice Questions:
1. Rank patients by satisfaction score within each service.*/
SELECT 
    name,
    service,
    satisfaction,
    RANK() OVER (
        PARTITION BY service
        ORDER BY satisfaction DESC
    ) AS satisfaction_rank
FROM patients;

/*2. Assign row numbers to staff ordered by their name.*/
SELECT 
    staff_name,
    ROW_NUMBER() OVER (ORDER BY staff_name) AS name_in_order
FROM staff;

/*3. Rank services by total patients admitted.*/
SELECT service,
 SUM(patients_admitted) as total_admitted,
 RANK() OVER (ORDER BY SUM(patients_admitted) DESC) admitted_rank
FROM services_weekly
 GROUP BY service;

/*Daily Challenge:
**Question:** For each service, rank the weeks by patient satisfaction score (highest first).
 Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.*/
 SELECT *
FROM (
    SELECT 
        service,
        week,
        patient_satisfaction,
        patients_admitted,
        RANK() OVER (
            PARTITION BY service
            ORDER BY patient_satisfaction DESC
        ) AS satisfaction_rank
    FROM services_weekly
) AS ranked_data
WHERE satisfaction_rank <= 3
ORDER BY service, satisfaction_rank, week;

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 