-- -----------------------------------------------------
-- Table `club`.`court`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `club`.`court` ;

CREATE TABLE IF NOT EXISTS `club`.`court` (
	`court_id` INT NOT NULL AUTO_INCREMENT,
	`court_no` INT NOT NULL,
	`court_surface` VARCHAR(256) NOT NULL,
	`court_type` VARCHAR(256) NOT NULL,
	`valid_from` DATE NOT NULL,
	`valid_to` DATE NOT NULL,
	PRIMARY KEY (`court_id`)) 
ENGINE = InnoDB;