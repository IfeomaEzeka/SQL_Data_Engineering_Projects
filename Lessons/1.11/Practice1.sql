--A query to ge the list of top 10 companies for posting jobs with each posting more than 3,000 jobs
EXPLAIN ANALYZE
SELECT
    cd.name AS comapany_name,
    COUNT(jpf.*) AS job_count
FROM   
    job_postings_fact AS jpf 
LEFT JOIN
    company_dim AS cd 
ON  
    jpf.company_id = cd.company_id
WHERE 
    jpf.job_country = 'United States'
GROUP BY 
    comapany_name
HAVING 
    job_count > 3_000
ORDER BY 
    job_count DESC 
LIMIT 
    10;