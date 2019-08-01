-- -----------------------------------------------------
-- Table `sport`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sport`.`team_members` ;

CREATE TABLE IF NOT EXISTS `sport`.`team_members` (
	`team_members_id` INT NOT NULL AUTO_INCREMENT,
	`team_id` INT NOT NULL,
	`player_id` INT NOT NULL,
	`is_main_team` BOOLEAN NOT NULL,
	PRIMARY KEY (`team_members_id`)) 
ENGINE = InnoDB;
