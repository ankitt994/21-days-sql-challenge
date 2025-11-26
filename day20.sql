/*Day 20 (26/11) : Window Functions - Aggregate Window Functions
**Topics:** SUM() OVER, AVG() OVER, running totals, moving averages
### Practice Questions:
1. Calculate running total of patients admitted by week for each service.*/
SELECT week, 
service, patients_admitted,
 SUM(patients_admitted)
 OVER (PARTITION BY service ORDER BY week) as running_total_admitted
FROM services_weekly
ORDER BY service, week;

/*2. Find the moving average of patient satisfaction over 4-week periods.*/
SELECT service,
    week,
    patient_satisfaction,
    AVG(patient_satisfaction) OVER (PARTITION BY service ORDER BY week
        ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
    ) AS moving_avg_4_weeks
FROM services_weekly
ORDER BY service, week;

/*3. Show cumulative patient refusals by week across all services.*/
SELECT week, 
month, service, patients_refused, SUM(patients_refused)
 OVER (ORDER BY week) as cumlative_patient_refusals 
 FROM services_weekly
 ORDER BY week;

/*Daily Challenge:
 Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative), 3-week moving average
 of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average. Filter for weeks 10-20 only.*/
 SELECT 
 service, 
 week, 
 patients_admitted, 
 SUM(patients_admitted) OVER(PARTITION BY service ORDER BY week
 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_patients_admitted,
 AVG(patient_satisfaction) OVER(PARTITION BY service ORDER BY week
 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3week_satifaction,
 patients_admitted 
        - (AVG(patients_admitted) OVER (PARTITION BY service))
        AS admission_vs_service_avg
FROM services_weekly
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;
 
 
 
 
 
 
 
 
 
 
 