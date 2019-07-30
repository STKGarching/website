-- -----------------------------------------------------
-- Table `sport`.`player`
-- ----------------------------------------------------- 
DROP TABLE IF EXISTS `sport`.`player` ;

CREATE TABLE IF NOT EXISTS `sport`.`player` (
	`player_id` INT NOT NULL AUTO_INCREMENT,
	`member_no` INT NOT NULL,
	PRIMARY KEY (`player_id`))
ENGINE = InnoDB;