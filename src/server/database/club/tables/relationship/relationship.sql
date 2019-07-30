-- -----------------------------------------------------
-- Table `club`.`relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`relationship` ;

CREATE TABLE IF NOT EXISTS `club`.`relationship` (
	`relationship_id` INT NOT NULL AUTO_INCREMENT,
	`source_id` INT NOT NULL,
	`source` VARCHAR(256) NOT NULL,
	`target_id` INT NOT NULL,
	`target` VARCHAR(256) NOT NULL,
	`relationship_type_id` INT NOT NULL,
	PRIMARY KEY (`relationship_id`),
	INDEX i_relationship_source_target (source_id,target_id),
	INDEX i_relationship_target_source (target_id,source_id))
ENGINE = InnoDB;
