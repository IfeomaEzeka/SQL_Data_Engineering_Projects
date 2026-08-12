INSERT INTO 
    staging.preferred_roles(role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Data Platfrom Engineer'),
    (3, 'Lead Data Engineer'),
    (4, 'Chief Data Officer');

SELECT * 
FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN ;

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id BETWEEN 1 AND 4; -- TO BE USED ONLY WHEN YOU HAVE SPECIFIC ROWS . IF THE CHANGE IS FOR ALL THE ROWS, IT IS NOT NEEDED

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT * 
FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INT;

UPDATE staging.priority_roles
SET priority_lvl = 2
WHERE role_id = 2;