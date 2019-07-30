-- -----------------------------------------------------
-- Table `club`.`task`
--
-- Ticket Relationships:
-- Ersteller (unique)
-- Bearbeiter (multiple)
-- Kommentar (multiple)
-- Abnehmer (multiple)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`task` ;

CREATE TABLE IF NOT EXISTS `club`.`task` (
	`task_id` INT NOT NULL AUTO_INCREMENT,
	`task_no` INT NOT NULL,
	`title` VARCHAR(256) NOT NULL,
	`description` BLOB,
	`priority_id` INT NOT NULL,
	`created_at` DATE NOT NULL,
	`modified_at` DATE NOT NULL,
	`due_date` DATE,
	`task_status_id` INT,
	`resolution_date` DATE,
	PRIMARY KEY (`task_id`))
ENGINE = InnoDB;
