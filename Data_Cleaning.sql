-- EP KIEU DU LIEU
UPDATE [Human Resources]
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN FORMAT(birthdate, 'yyyy-mm-dd')
    WHEN birthdate LIKE '%-%' THEN FORMAT(birthdate, 'yyyy-mm-dd')
    ELSE NULL
END;

GO 

UPDATE [Human Resources]
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN FORMAT(CONVERT(DATE,hire_date), 'yyyy-mm-dd')
    WHEN hire_date LIKE '%-%' THEN FORMAT(CONVERT(DATE,hire_date), 'yyyy-mm-dd')
    ELSE NULL
END;


GO

UPDATE [Human Resources]
SET termdate = CAST(LEFT(termdate, 19) AS DATETIME)
WHERE termdate IS NOT NULL OR termdate != ''

GO

ALTER TABLE [Human Resources]
ADD age INT

GO
UPDATE [Human Resources]
SET age = DATEDIFF(YEAR,birthdate, GETDATE());


GO
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM [Human Resources]


GO
SELECT count(*) FROM [Human Resources] WHERE age < 18;

SELECT Distinct(location) FROM [Human Resources];

SELECT COUNT(*) FROM [Human Resources] WHERE termdate > GETDATE() OR termdate IS NULL;

