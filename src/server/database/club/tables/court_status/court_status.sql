-- -----------------------------------------------------
-- Table `club`.`court_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`court_status` ;

CREATE TABLE IF NOT EXISTS `club`.`court_status` (
	`court_status_id` INT NOT NULL AUTO_INCREMENT,
	`court_id` INT NOT NULL,
	`court_status_list_id` VARCHAR(256) NOT NULL,
	`valid_from` DATETIME NOT NULL,
	`valid_to` DATETIME NOT NULL,
	`changed_by` INT NOT NULL,
	PRIMARY KEY (`court_status_id`))
ENGINE = InnoDB;
