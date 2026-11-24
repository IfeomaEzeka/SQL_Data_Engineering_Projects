CREATE OR REPLACE TABLE staging.priority_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR,
    priority_lvl INTEGER
);

INSERT INTO staging.priority_roles(role_id, role_name, priority_lvl)
VALUES
    (1, 'Data Engineer', 1),
    (2, 'Software Engineer', 3),
    (3, 'Data Scientist', 4);
SELECT * FROM staging.priority_roles;