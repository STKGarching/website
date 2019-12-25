-- -----------------------------------------------------
-- Table `club`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`person` ;

CREATE TABLE IF NOT EXISTS `club`.`person` (
	`person_id` INT NOT NULL AUTO_INCREMENT,
	`person_no` INT NOT NULL,
  `is_member` BOOLEAN NOT NULL,
	`member_no` INT,
	`first_name` VARCHAR(256) NOT NULL,
	`last_name` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`person_id`))
ENGINE = InnoDB;
