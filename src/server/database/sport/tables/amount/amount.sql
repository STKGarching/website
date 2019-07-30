-- -----------------------------------------------------
-- Table `sport`.`amount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sport`.`amount` ;

CREATE TABLE IF NOT EXISTS `sport`.`amount` (
	`amount_id` INT NOT NULL AUTO_INCREMENT,
	`amount_name` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`amount_id`)) 
ENGINE = InnoDB;