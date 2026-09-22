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

WITH title_median AS(
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg) ::INT AS market_medain_salary
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY 
        job_title_short,
        job_work_from_home
)
SELECT 
    r.job_title_short,
    r.market_medain_salary AS remote_median,
    o.market_medain_salary AS onsite_median,
    (r.market_medain_salary - o.market_medain_salary ) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;


--Existence filtering
SELECT *
FROM range(10) AS src(key);

SELECT *
FROM range(5) AS tgt(key);

SELECT *
FROM range(10) AS src(key)
WHERE EXISTS(
    SELECT 1
    FROM range(5) AS tgt(key)
    WHERE tgt.key = src.key
);

SELECT *
FROM range(10) AS src(key)
WHERE NOT EXISTS(
    SELECT 1 --you can use anything, it still works. 1 is jsut the 
    FROM range(5) AS tgt(key)
    WHERE tgt.key = src.key
);

--Finding jobs that have no associated skill 
SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;

SELECT *
FROM job_postings_fact AS jpf 
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd 
    WHERE jpf.job_id = sjd.job_id
)


SELECT 
    jpf.job_title_short
FROM job_postings_fact AS jpf 
WHERE EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd 
    WHERE jpf.job_id = sjd.job_id
)
LIMIT 10;

SELECT 
    COUNT(*)
FROM job_postings_fact AS jpf 
WHERE EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd 
    WHERE jpf.job_id = sjd.job_id
);

SELECT 
    COUNT(*)
FROM job_postings_fact AS jpf ;

SELECT 
    COUNT(*)
FROM job_postings_fact AS jpf 
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd 
    WHERE jpf.job_id = sjd.job_id
);