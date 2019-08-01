-- -----------------------------------------------------
-- Table `club`.`task_priority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`task_priority` ;

CREATE TABLE IF NOT EXISTS `club`.`task_priority` (
	`task_priority_id` INT NOT NULL AUTO_INCREMENT,
	`task_priority_no`INT NOT NULL,
	`task_priority` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`task_priority_id`))
ENGINE = InnoDB;
