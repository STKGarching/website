DROP PROCEDURE IF EXISTS `club`.`p_court_status_insert`;
DELIMITER //
CREATE PROCEDURE `club`.`p_court_status_insert` (var_court_no INT,var_court_status_list_id INT,var_valid_from DATETIME,var_valid_to DATETIME,var_changed_by VARCHAR(256))

BEGIN

INSERT INTO `club`.`tmp_court_status` (court_status_id,solution)
SELECT basis.court_status_id,basis.solution FROM
(
  SELECT cs.court_status_id,'A' as solution FROM `club`.`court_status` cs
  WHERE 1=1
  AND cs.valid_to < IFNULL(var_valid_to,cs.valid_to)
  AND cs.valid_from < var_valid_from
  AND cs.valid_to > var_valid_from
  and cs.court_no = var_court_no
  UNION
  SELECT cs.court_status_id,'B' as solution FROM `club`.`court_status` cs
  WHERE 1=1
  AND cs.valid_from > var_valid_from
  AND cs.valid_from < IFNULL(var_valid_to,cs.valid_to)
  AND cs.valid_to >= IFNULL(var_valid_to,cs.valid_to)
  and cs.court_no = var_court_no
  UNION
  SELECT cs.court_status_id,'C2' as solution FROM `club`.`court_status` cs
  WHERE 1=1
  AND cs.valid_from < var_valid_from
  AND cs.valid_to = IFNULL(var_valid_to,cs.valid_to)
  and cs.court_no = var_court_no
  UNION
  SELECT cs.court_status_id,'C3' as solution FROM `club`.`court_status` cs
  WHERE 1=1
  AND cs.valid_from = var_valid_from
  AND cs.valid_to > IFNULL(var_valid_to,cs.valid_to)
  and cs.court_no = var_court_no
  UNION
  SELECT cs.court_status_id,'C4' as solution FROM `club`.`court_status` cs
  WHERE 1=1
  AND cs.valid_from < var_valid_from
  AND cs.valid_to > IFNULL(var_valid_to,cs.valid_to)
  and cs.court_no = var_court_no
  UNION
  SELECT cs.court_status_id,'D' as solution FROM `club`.`court_status` cs
  WHERE 1=1
  AND cs.valid_from >= var_valid_from
  AND cs.valid_to <= IFNULL(var_valid_to,cs.valid_to)
  and cs.court_no = var_court_no
) basis;

-- DELETE
DELETE cs.* FROM `club`.`court_status` cs
RIGHT JOIN `club`.`tmp_court_status` tcs
ON cs.court_status_id = tcs.court_status_id
WHERE 1=1
AND tcs.solution = 'D';

-- DUBLICATE
INSERT INTO `club`.`court_status` (court_no,court_status_list_id,valid_from,valid_to,changed_by)
SELECT cs.court_no,cs.court_status_list_id,var_valid_to as valid_from,cs.valid_to,var_changed_by FROM  `club`.`court_status` cs
RIGHT JOIN `club`.`tmp_court_status` tcs
ON cs.court_status_id = tcs.court_status_id
WHERE 1=1
AND tcs.solution IN ('C4');

-- UPDATE
UPDATE `club`.`court_status` cs
RIGHT JOIN `club`.`tmp_court_status` tcs
ON cs.court_status_id = tcs.court_status_id
AND tcs.solution <>  'D'
SET cs.valid_to = CASE
  WHEN tcs.solution IN ('A','C2','C4') THEN var_valid_from
  ELSE cs.valid_to
END
, cs.valid_from = CASE
  WHEN tcs.solution IN ('B','C3') THEN IFNULL(var_valid_to,cs.valid_to)
  ELSE cs.valid_from
END
, cs.changed_by = var_changed_by;

TRUNCATE TABLE `club`.`tmp_court_status`;

INSERT INTO `club`.`court_status` (court_no,court_status_list_id,valid_from,valid_to,changed_by) VALUES (var_court_no,var_court_status_list_id,var_valid_from,IFNULL(var_valid_to,'9999-12-31 23:59:59'),var_changed_by);

END //
DELIMITER ;
