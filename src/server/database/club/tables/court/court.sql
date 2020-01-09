-- -----------------------------------------------------
-- Table club.court
-- -----------------------------------------------------
SELECT
    root.f_check_if_table_exists ('club',
        'court',
        TRUE);

CREATE TABLE IF NOT EXISTS club.court (
        court_id SERIAL PRIMARY KEY,
        court_no INT NOT NULL,
        court_surface VARCHAR(256) NOT NULL,
        court_type VARCHAR(256) NOT NULL,
        valid_from TIMESTAMPTZ NOT NULL,
        valid_to TIMESTAMPTZ NOT NULL,
        changed_by INT NOT NULL
);
