DROP TABLE IF EXISTS `club`.`tmp_court_status` ;

CREATE TABLE IF NOT EXISTS `club`.`tmp_court_status` (
                `court_status_id` INT NOT NULL,
                `solution` VARCHAR(8) NOT NULL)
ENGINE = InnoDB;
