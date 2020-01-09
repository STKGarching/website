-- -----------------------------------------------------
-- Table club.comment
--
-- Kommentar Relationships;
-- Ersteller (unique)
-- -----------------------------------------------------
SELECT
    root.f_check_if_table_exists ('club',
        'comment',
        TRUE);

CREATE TABLE IF NOT EXISTS club.comment (
        comment_id BIGSERIAL PRIMARY KEY,
        title VARCHAR(256) NOT NULL,
        COMMENT VARCHAR(256) NOT NULL,
        created_at TIMESTAMPTZ NOT NULL,
        modified_at TIMESTAMPTZ NOT NULL
);
