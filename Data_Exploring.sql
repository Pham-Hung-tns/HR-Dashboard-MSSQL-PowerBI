-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT GENDER ,COUNT(GENDER) AS TOTAL_EMPLOYEE 
FROM [Human Resources]
GROUP BY gender
ORDER BY TOTAL_EMPLOYEE DESC


-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT RACE ,COUNT(RACE) AS TOTAL_EMPLOYEE 
FROM [Human Resources]
GROUP BY race
ORDER BY TOTAL_EMPLOYEE DESC


-- 3. What is the age distribution of employees in the company?
SELECT MIN(AGE) AS MIN_AGE, MAX(AGE) AS MAX_AGE
FROM [Human Resources]



-- 4. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*)
FROM [Human Resources]
GROUP BY location


SELECT location, location_city, location_state, COUNT(*)
FROM [Human Resources]
GROUP BY location, location_city, location_state



-- 5. What is the average length of employment for employees who have been terminated?

SELECT AVG(DATEDIFF(YEAR, hire_date, termdate)) AS AVG_timeserving
FROM [Human Resources]
WHERE termdate <= GETDATE() AND termdate IS NOT NULL


SELECT AVG(DATEDIFF(MONTH, hire_date, termdate)) AS AVG_timeserving
FROM [Human Resources]
WHERE termdate <= GETDATE() AND termdate IS NOT NULL




-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, jobtitle, COUNT(gender) AS TOTAL_EMP_BY_GENDER
FROM [Human Resources]
GROUP BY gender, department, jobtitle
ORDER BY department ASC ,TOTAL_EMP_BY_GENDER DESC



-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) as count
FROM [Human Resources]
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;



-- 8. Which department has the highest turnover rate?
SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= GETDATE() AND termdate IS NOT NULL THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate IS NULL THEN 1 ELSE 0 END) as active_count,
    CONVERT(DECIMAL(10,2), 
    SUM(CASE WHEN termdate <= GETDATE() AND termdate IS NOT NULL THEN 1 ELSE 0 END) * 1.0 
    / COUNT(*)
) AS termination_rate

FROM [Human Resources]
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;



-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, COUNT(*) as count
FROM [Human Resources]
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;


-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate IS NOT NULL AND termdate <= GETDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate IS NOT NULL AND termdate <= GETDATE() THEN 1 ELSE 0 END) AS net_change,
    CONVERT(DECIMAL(10,2),((COUNT(*) - SUM(CASE WHEN termdate IS NOT NULL AND termdate <= GETDATE() THEN 1 ELSE 0 END)* 1.0) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    [Human Resources]
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;



-- 11. What is the tenure distribution for each department?
SELECT department, ROUND(AVG(DATEDIFF(YEAR,termdate, GETDATE())),0) as avg_tenure
FROM [Human Resources]
WHERE termdate <= GETDATE() AND termdate IS NOT NULL AND age >= 18
GROUP BY department