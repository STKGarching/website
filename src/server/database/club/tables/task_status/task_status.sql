-- -----------------------------------------------------
-- Table `club`.`task_status`
--
-- "Erstellt": sollen nur für Administratoren sichtbar sein. Damit soll eine Planung ermöglicht werden. Außerdem kann man so schnell etwas erfassen und erst später ausarbeiten.
-- "Offen": können vom Mitglieder übernommen werden
-- "in Bearbeitung": werden derzeit bearbeitet
-- "Gelöst": Der/Die Ticketbearbeiter haben das Ticket gelöst und warten auf Abnahme
-- "Abgenommen": Ticket ist final abgeschlossen
-- "Nachbesserung nötig": Der/Die Bearbeiter müssen nochmals nachbessern um das Ticket abzuschließen.
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club`.`task_status` ;

CREATE TABLE IF NOT EXISTS `club`.`task_status` (
	`task_status_id` INT NOT NULL AUTO_INCREMENT,
	`task_status_no` INT NOT NULL,
	`task_status` VARCHAR(256) NOT NULL,
	PRIMARY KEY (`task_status_id`))
ENGINE = InnoDB;
