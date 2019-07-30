-- -----------------------------------------------------
-- Table `sport`.`benefit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sport`.`benefit` ;

CREATE TABLE IF NOT EXISTS `sport`.`benefit` (
	`benefit_id` INT NOT NULL AUTO_INCREMENT,
	`benefit_type_id` INT NOT NULL COMMENT 'type of the benefit',
	`entity_id` INT NOT NULL COMMENT 'id of the entity',
	`entity` VARCHAR(128) NOT NULL COMMENT 'entity to which the benefit belongs. This can be a player or a team',
	`description` VARCHAR(256) NULL COMMENT 'optional description of the benefit',
	`valid_from` DATE NOT NULL,
	`valid_to` DATE NOT NULL,
	`count` FLOAT(8,2) NOT NULL COMMENT 'Number of benefits in the given time period',
	`amount_id` INT NOT NULL,
	`value` DECIMAL(8,2) COMMENT 'The value in EUR of the n-th count. That means if count is n, value describes the EUR of 1 count. value can be NULL but in this case the cap_sum_value should be filled.',
	`cap_sum_value` DECIMAL(8,2) COMMENT 'Maximum Sum of EUR that must not be exceeded by the benefit. That means for example. You have 3 Tournaments but the cost of all 3 should no exceed 100 EUR.',
	`is_claimable` BOOLEAN NOT NULL COMMENT 'Some benefits are claimable. For example tournaments can have an upper cap in EUR and the complete sum may not be claimed. This should be recorded.',
	PRIMARY KEY (`benefit_id`))
ENGINE = InnoDB;
