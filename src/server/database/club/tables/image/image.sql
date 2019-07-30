-- -----------------------------------------------------
-- Table `club`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`image` ;

CREATE TABLE IF NOT EXISTS `club`.`image` (
	`image_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(256) NOT NULL,
	`url` VARCHAR(256) NOT NULL,
	`created_at` DATE NOT NULL,
	`modified_at` DATE NOT NULL,
	PRIMARY KEY (`image_id`))
ENGINE = InnoDB;