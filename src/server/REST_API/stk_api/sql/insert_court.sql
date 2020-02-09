INSERT INTO club.court (court_id, court_no, court_surface, court_type, valid_from, valid_to, modified_at, changed_by)
SELECT
    COALESCE({0}, max(court_no)+1), {1}, {2}, {3}, COALESCE({4}, CURRENT_TIMESTAMP), COALESCE({5}, TIMESTAMPTZ '9999-12-31 23:59:59'), COALESCE({6}, CURRENT_TIMESTAMP), {7} from club.court;

