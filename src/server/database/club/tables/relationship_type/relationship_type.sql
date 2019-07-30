-- -----------------------------------------------------
-- Table `club`.`relationship_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`relationship_type` ;

CREATE TABLE IF NOT EXISTS `club`.`relationship_type` (
	`relationship_type_id` INT NOT NULL AUTO_INCREMENT,
	`relationship_type_no` INT NOT NULL,
	`relationship_type` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`relationship_type_id`))
ENGINE = InnoDB;