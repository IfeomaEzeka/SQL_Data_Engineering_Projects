CREATE OR REPLACE TABLE main.priority_jobs_snapshot(
    job_id INTEGER PRIMARY KEY, -- job posting fact table
    job_title_short VARCHAR, -- job posting fact table
    company_name VARCHAR, --company dim
    job_posted_date TIMESTAMP, -- job posting fact table
    salary_year_avg DOUBLE, -- job posting fact table
    priority_lvl INTEGER, -- priority role
    updated_at TIMESTAMP
);

INSERT INTO main.priority_jobs_snapshot(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
    SELECT 
        jpf.job_id,
        jpf.job_title_short,
        cd.name,
        jpf.job_posted_date,
        jpf.salary_year_avg,
        pr.priority_lvl,
        CURRENT_TIMESTAMP
    FROM    
        data_jobs.job_postings_fact AS jpf
    LEFT JOIN 
        data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
    INNER JOIN
        staging.priority_roles AS pr
    ON jpf.job_title_short = pr.role_name;


SELECT 
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) AS updated_at
FROM main.priority_jobs_snapshot
GROUP BY job_title_short
ORDER BY job_count DESC;