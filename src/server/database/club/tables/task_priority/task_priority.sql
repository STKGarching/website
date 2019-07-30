-- -----------------------------------------------------
-- Table `club`.`task_priority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`task_priority` ;

CREATE TABLE IF NOT EXISTS `club`.`task_priority` (
	`priority_id` INT NOT NULL AUTO_INCREMENT,
	`priority_no`INT NOT NULL,
	`priority` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`priority_id`))
ENGINE = InnoDB;