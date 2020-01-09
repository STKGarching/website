-- -----------------------------------------------------
-- Table sport.team
-- -----------------------------------------------------
SELECT
    root.f_check_if_table_exists ('sport',
        'team',
        TRUE);

CREATE TABLE IF NOT EXISTS sport.team (
        team_id SERIAL PRIMARY KEY,
        team_name VARCHAR(256) NOT NULL,
        season VARCHAR(256) NOT NULL,
        valid_from TIMESTAMPTZ NULL,
        valid_to TIMESTAMPTZ NULL
);

COMMENT ON COLUMN team.season IS 'Winter- or Sommerrunde';
