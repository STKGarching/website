SELECT
    c.court_id,
    c.court_no,
    csl.court_status_name,
    c.court_surface,
    c.court_type
FROM
    club.court_status cs
        LEFT JOIN
    club.court_status_list csl ON cs.court_status_list_id = csl.court_status_list_id
        LEFT JOIN
    club.court c ON cs.court_id = c.court_id
WHERE
    1 = 1 AND cs.valid_to > {0}
        AND cs.valid_from <= {0}
        AND c.valid_to > {0}
        AND c.valid_from <= {0}