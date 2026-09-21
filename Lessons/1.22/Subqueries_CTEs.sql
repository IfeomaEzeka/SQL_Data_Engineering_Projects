--Subquery
SELECT *
FROM(
    SELECT *
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL
    OR salary_year_avg IS NOT NULL
)
AS salary_jobs
LIMIT 10;

SELECT 
    job_title_short, 
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact
    )AS market_meidan_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

SELECT 
    job_title_short, 
    salary_year_avg,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact 
        WHERE job_work_from_home IS TRUE
    )AS market_meidan_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

SELECT 
    job_title_short, 
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact 
        WHERE job_work_from_home IS TRUE
    )AS market_meidan_salary
FROM(
    SELECT 
    job_title_short,
    salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
    ) AS clean_jobs
GROUP BY job_title_short
LIMIT 10;

SELECT 
    job_title_short, 
    MEDIAN(salary_year_avg) AS median_salary,
    (
        SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact 
        WHERE job_work_from_home IS TRUE
    )AS market_meidan_salary
FROM(
    SELECT 
    job_title_short,
    salary_year_avg
    FROM job_postings_fact
    WHERE job_work_from_home = TRUE
    ) AS clean_jobs
GROUP BY job_title_short
HAVING MEDIAN(salary_year_avg) > 
        (
         SELECT MEDIAN(salary_year_avg)
        FROM job_postings_fact 
        WHERE job_work_from_home IS TRUE
        )
LIMIT 10;

--CTEs
WITH salary_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL
    OR salary_year_avg IS NOT NULL   
)
SELECT * FROM salary_jobs
LIMIT 10;