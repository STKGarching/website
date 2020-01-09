-- -----------------------------------------------------
-- Table club.person
-- -----------------------------------------------------
SELECT
    root.f_check_if_table_exists ('club',
        'person',
        TRUE);

CREATE TABLE IF NOT EXISTS club.person (
        person_id SERIAL PRIMARY KEY,
        person_no INT NOT NULL,
        is_member BOOLEAN NOT NULL,
        member_no INT,
        first_name VARCHAR(256) NOT NULL,
        last_name VARCHAR(256) NOT NULL
);
