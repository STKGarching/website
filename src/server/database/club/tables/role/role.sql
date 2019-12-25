-- -----------------------------------------------------
-- Table `club`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`role` ;

CREATE TABLE IF NOT EXISTS `club`.`role` (
	`role_id` INT NOT NULL AUTO_INCREMENT,
	`role_no` INT NOT NULL,
  `role` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`role_id`))
ENGINE = InnoDB;
