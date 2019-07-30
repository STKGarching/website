-- -----------------------------------------------------
-- Table `sport`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sport`.`team` ;

CREATE TABLE IF NOT EXISTS `sport`.`team` (
	`team_id` INT NOT NULL AUTO_INCREMENT,
	`team_name` VARCHAR(256) NOT NULL,
	`season` VARCHAR(256) NOT NULL COMMENT 'Winter- or Sommerrunde',
	`valid_from` DATE NULL,
	`valid_to` DATE NULL,
	PRIMARY KEY (`team_id`))
ENGINE = InnoDB;
