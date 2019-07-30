-- -----------------------------------------------------
-- Table `club`.`court_status_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`court_status_list` ;

CREATE TABLE IF NOT EXISTS `club`.`court_status_list` (
	`court_status_list_id` INT NOT NULL AUTO_INCREMENT,
	`court_status_name` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`court_status_list_id`))
ENGINE = InnoDB;
