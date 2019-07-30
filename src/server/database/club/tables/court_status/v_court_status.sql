CREATE OR REPLACE VIEW `club`.`v_court_status` AS
SELECT cs.court_no
     , csl.court_status_name
FROM `club`.`court_status` cs
LEFT JOIN `club`.`court_status_list` csl
ON cs.court_status_list_id = csl.court_status_list_id
WHERE 1=1
AND cs.valid_from <= NOW()
AND cs.valid_to > NOW()
ORDER BY cs.court_no ASC;
