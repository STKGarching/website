-- -----------------------------------------------------
-- Table `sport`.`claim`
-- Claimable Benefits, e.g. tournaments, are listed here when they are really used by the player or team.
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sport`.`claim` ;

CREATE TABLE IF NOT EXISTS `sport`.`claim` (
	`claim_id` INT NOT NULL AUTO_INCREMENT,
	`benefit_id` INT NOT NULL,
	`description` VARCHAR(256) NULL COMMENT 'optional description of the claim',
	`created_at` DATE NOT NULL,
	`value` DECIMAL(8,2) COMMENT 'The value in EUR.',
	PRIMARY KEY (`claim_id`))
ENGINE = InnoDB;
