/*Day 10 (13/11): CASE Statements Topics: CASE WHEN, conditional logic, derived columns
Practice Questions: 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.*/
SELECT name, satisfaction,
(CASE WHEN satisfaction >= 67 THEN "High"
		  WHEN satisfaction >= 34 AND satisfaction < 67 THEN "Medium"
          ELSE "Low" end) as Categorise
FROM patients;

/*2. Label staff roles as 'Medical' or 'Support' based on role type.*/
SELECT staff_name, role, 
(CASE WHEN role IN('doctor', 'nurse') THEN 'Medical'
ELSE "Support" end) as staff_label FROM staff;

/*3. Create age groups for patients (0-18, 19-40, 41-65, 65+).*/
SELECT name, (CASE WHEN age > 65 THEN 'retired'
                   WHEN age BETWEEN 41 and 65 THEN 'senior'
                    WHEN age BETWEEN 19 and 40 THEN 'junior'
		            WHEN age <= 18 THEN 'underage' else 'other' end) as age_category FROM patients;

/*Daily Challenge:
**Question:** Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 
'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.*/
SELECT service, COUNT(*) as total_patients, AVG(patient_satisfaction) as avg_satisfaction, (CASE WHEN
 AVG(patient_satisfaction) >= 85 THEN 'Excellent' 
  WHEN AVG(patient_satisfaction) >= 75 THEN 'Good'
 WHEN AVG(patient_satisfaction) >= 65 THEN 'Fair' ELSE 'Needs Improvement' END) as performance_category FROM services_weekly
 GROUP BY service
ORDER BY avg_satisfaction DESC;







