CREATE DATABASE IF NOT EXISTS job_mart;

SELECT *
FROM information_schema.schemata;

DROP DATABASE IF EXISTS job_mart;

CREATE SCHEMA IF NOT EXISTS job_mart.staging;

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'job_mart';

USE job_mart;

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INT,
    role_name VARCHAR
);

DROP TABLE IF EXISTS main.preferred_roles ;