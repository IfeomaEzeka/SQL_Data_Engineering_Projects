--SELECT CAST(123 AS VARCHAR);

--Convert the following to a diffrent data type as specified

SELECT 
    CAST(job_id AS CHAR(10)) ||'-'|| CAST(company_id AS CHAR(10)) AS new_id,
    CAST(job_work_from_home AS INT) AS job_work_from_home, --boolean to numeric
    CAST(job_posted_date AS DATE ) AS job_posted_date, --timestamp to date 
    CAST (salary_year_avg AS DECIMAL(10,0)) AS salary_year_avg--double to no decimal place
FROM    
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 
    10;