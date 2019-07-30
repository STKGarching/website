-- -----------------------------------------------------
-- Table `sport`.`benefit_type`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `sport`.`benefit_type` ;

CREATE TABLE IF NOT EXISTS `sport`.`benefit_type` (
	`benefit_type_id` INT NOT NULL AUTO_INCREMENT,
	`benefit_type_name` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`benefit_type_id`)) 
ENGINE = InnoDB;