-- -----------------------------------------------------
-- Table `sport`.`contribution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sport`.`contribution` ;

CREATE TABLE IF NOT EXISTS `sport`.`contribution` (
	`contribution_id` INT NOT NULL AUTO_INCREMENT,
	`benefit_id` INT NOT NULL,
	`description` VARCHAR(256) NULL COMMENT 'optional description of the contribution',
	`created_at` DATE NOT NULL,
	`value` DECIMAL(8,2) COMMENT 'The value in EUR.',
	PRIMARY KEY (`contribution_id`))
ENGINE = InnoDB;
