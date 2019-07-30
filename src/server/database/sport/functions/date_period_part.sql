USE `sport`;
DROP FUNCTION IF EXISTS `date_period_part`;

DELIMITER //
USE `sport`//

CREATE FUNCTION `date_period_part` (var_from_input DATE,var_to_input DATE,var_from DATE,var_to DATE)
RETURNS DOUBLE BEGIN

DECLARE result double;

SET result = IF(DATEDIFF(var_from_input, var_from) <= 0 /* var_from_input vor var_from */,
	IF(DATEDIFF(var_to_input, var_to) <= 0 /* var_to_input vor var_to */,
			DATEDIFF(var_to_input, var_from) ,
      DATEDIFF(var_to, var_from)),
  IF(DATEDIFF(var_to_input, var_to) <= 0 /* var_to_input vor var_to */,
			DATEDIFF(var_to_input, var_from_input) ,
      DATEDIFF(var_to, var_from_input))
	) / DATEDIFF(var_to, var_from);

RETURN result;
END//
DELIMITER ;
