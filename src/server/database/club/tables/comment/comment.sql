-- -----------------------------------------------------
-- Table `club`.`comment`
--
-- Kommentar Relationships;
-- Ersteller (unique)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`comment` ;

CREATE TABLE IF NOT EXISTS `club`.`comment` (
	`comment_id` INT NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(256) NOT NULL,
	`comment` VARCHAR(256) NOT NULL,
	`created_at` DATE NOT NULL,
	`modified_at` DATE NOT NULL,
	PRIMARY KEY (`comment_id`))
ENGINE = InnoDB;
