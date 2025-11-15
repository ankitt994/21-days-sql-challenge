/*Day 12 (15/11): NULL Values and IS NULL/IS NOT NULL #Topics: NULL handling, IS NULL, IS NOT NULL, COALESCE
1. Find all weeks in services_weekly where no special event occurred.*/
SELECT * FROM services_weekly WHERE event IS NULL;

/*2. Count how many records have null or empty event values.*/
SELECT COUNT(*) AS total_null_or_empty_events
FROM services_weekly
WHERE event IS NULL OR event = '';

/*3. List all services that had at least one week with a special event.*/
SELECT DISTINCT service
FROM services_weekly
WHERE event IS NOT NULL 
  AND event <> '';

/* Daily Challenge:  Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'), count of weeks, 
average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.*/
SELECT (CASE WHEN COALESCE(event, 'none') = 'none' THEN "With Event" ELSE
"No Event" END) as Event_status, COUNT(*) as count_of_weeks, AVG(patient_satisfaction) as avg_patient_satisfaction, AVG(staff_morale) as avg_staff_morale
 FROM services_weekly
GROUP BY Event_status
ORDER BY avg_patient_satisfaction DESC;

