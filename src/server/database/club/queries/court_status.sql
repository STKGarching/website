set @var_date:='2019-07-15 00:00:00';

SELECT
    cs.court_no,
    csl.court_status_name,
    c.court_surface,
    c.court_type
FROM
    club.court_status cs
        LEFT JOIN
    club.court_status_list csl ON cs.court_status_list_id = csl.court_status_list_id
        LEFT JOIN
    club.court c ON cs.court_no = c.court_no
WHERE
    1 = 1 AND cs.valid_to > @var_date
        AND cs.valid_from <= @var_date
        AND c.valid_to > @var_date
        AND c.valid_from <= @var_date
