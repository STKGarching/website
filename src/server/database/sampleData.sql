-- -------
-- Club --
-- -------
-- Person
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (1,TRUE,1,'Max','Mustermann');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (2,TRUE,2,'Paul','Panzer');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (3,TRUE,3,'Boris','Banane');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (4,TRUE,4,'Daniel','Düsentrieb');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (5,TRUE,5,'Susi','Sorglos');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (6,TRUE,6,'Nina','Nutzlos');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (7,TRUE,7,'Sabine','Saubermann');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (8,TRUE,8,'Maria','Mustermann');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (9,FALSE,NULL,'Peter','Platzwart');
INSERT INTO club.person (person_no,is_member,member_no,first_name,last_name) VALUES (10,TRUE,10,'Martin','Mannschaftslos');

-- Rollen
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (1,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (2,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (3,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (4,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (5,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (6,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (7,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (8,'person',2,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (9,'person',1,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (9,'person',4,'role',6);
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (10,'person',2,'role',6);
-- Image
-- Image von Paul Panzer
INSERT INTO club.image (name,url,created_at,modified_at) VALUES ('Profilbild Paul Panzer','https://www.stk-garching.de/paul','2019-04-01 00:00:00','2019-04-01 00:00:00');
-- Image vo Boris Banane
INSERT INTO club.image (name,url,created_at,modified_at) VALUES ('Profilbild Boris Banane','https://www.stk-garching.de/boris','2019-04-01 00:00:00','2019-04-01 00:00:00');
-- Image von Daniel Düsentrieb
INSERT INTO club.image (name,url,created_at,modified_at) VALUES ('Profilbild Daniel Düsentrieb','https://www.stk-garching.de/daniel','2019-04-01 00:00:00','2019-04-01 00:00:00');

-- Task (ein offener Task und ein erstellter Task)
INSERT INTO club.task (task_no,title,description,task_priority_id,created_at,modified_at,due_date,task_status_id,resolution_date) VALUES (1,'Sprenkler wechseln','Defekten Sprenkler auf Platz 13 wechseln',2,'2019-06-01 10:47:13','2019-06-01 10:47:13',NULL,1,NULL);
INSERT INTO club.task (task_no,title,description,task_priority_id,created_at,modified_at,due_date,task_status_id,resolution_date) VALUES (2,'Hecke schneiden','Hecke zwischen Platz 3 und Platz 4 schneiden.',3,'2019-06-12 15:15:58','2019-06-12 15:35:47',NULL,2,NULL);

-- Task 1
-- Ersteller
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (1,'task',9,'person',2);
-- Abnehmer
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (1,'task',9,'person',3);

-- Task 2
-- Ersteller
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (2,'task',9,'person',2);
-- Abnehmer
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (2,'task',9,'person',3);
-- Bearbeiter 1
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (1,'task',2,'person',1);
-- Bearbeiter 2
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (1,'task',3,'person',1);
-- Kommentar
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (2,'task',1,'comment',4);
-- Ersteller des Kommentar
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (1,'comment',3,'person',2);

-- Person 1 - Image
-- Image von Paul Panzer
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (2,'person',1,'image',5);
-- Image vo Boris Banane
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (3,'person',2,'image',5);
-- Image von Daniel Düsentrieb
INSERT INTO club.relationship (source_id,source,target_id,target,relationship_type_id) VALUES (4,'person',3,'image',5);

-- comment
-- Kommentar zu Task 2
INSERT INTO club.comment (title,comment,created_at,modified_at) VALUES ('Höhe','Wie hoch soll denn die Hecke noch sein?','2019-06-12 15:40:13','2019-06-12 15:40:13');

-- --------
-- Sport --
-- --------

-- Players
INSERT INTO sport.player (member_no) VALUES (1);
INSERT INTO sport.player (member_no) VALUES (2);
INSERT INTO sport.player (member_no) VALUES (3);
INSERT INTO sport.player (member_no) VALUES (4);
INSERT INTO sport.player (member_no) VALUES (5);
INSERT INTO sport.player (member_no) VALUES (6);
INSERT INTO sport.player (member_no) VALUES (7);
INSERT INTO sport.player (member_no) VALUES (8);
INSERT INTO sport.player (member_no) VALUES (10);

-- Teams
INSERT INTO sport.team (team_name,season,valid_from,valid_to) VALUES ('Herren','Sommerrunde 2019','2019-04-01 00:00:00','2019-09-30 23:59:59');
INSERT INTO sport.team (team_name,season,valid_from,valid_to) VALUES ('Herren 2','Sommerrunde 2019','2019-04-01 00:00:00','2019-09-30 23:59:59');
INSERT INTO sport.team (team_name,season,valid_from,valid_to) VALUES ('Damen','Sommerrunde 2019','2019-04-01 00:00:00','2019-09-30 23:59:59');

-- Team Members
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (1,1,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (1,2,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (1,3,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (1,4,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (3,5,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (3,6,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (3,7,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (3,8,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (2,9,true);
INSERT INTO sport.team_members (team_id,player_id,is_main_team) VALUES (1,9,false);
-- Benefit
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,1,'team','Hallentraining Herren am Samstag','2018-09-25 00:00:00','2019-04-20 23:59:59',50,1,22,NULL,false);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (3,2,'team','Trainer im Sommer für Damen','2019-04-15 00:00:00','2019-09-30 23:59:59',15,1,46,NULL,false);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,2,'team','Hallentraining Damen am Dienstag erste Stunde','2018-09-25 00:00:00','2019-04-20 23:59:59',25,1,18,NULL,false);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,2,'team','Hallentraining Damen am Dienstag zweite Stunde','2018-09-25 00:00:00','2019-04-20 23:59:59',25,1,20,NULL,false);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,1,'team','Trainingsbälle Herren','2019-01-01 00:00:00','2019-12-31 23:59:59',104,2,6.9,NULL,false);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (8,1,'team','Essen Heimspiele','2019-05-01 00:00:00','2019-08-31 23:59:59',4,3,NULL,240,true);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (5,1,'player','Turnierunterstützung Max','2019-01-01 00:00:00','2019-12-31 23:59:59',4,3,NULL,200,true);
INSERT INTO sport.benefit (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (7,2,'player','Spielergehalt Paul','2019-01-01 00:00:00','2019-12-31 23:59:59',7,3,NULL,2100,true);


-- claim
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (6,'Mannschaftsessen Heimspiel vs TC Tennis','2019-05-07',54.2);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (6,'Mannschaftsessen Heimspiel vs TC Tischennis','2019-05-21',58.6);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (6,'Mannschaftsessen Heimspiel vs TC Fussballtennis','2019-06-26',60);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (7,'Bezirksmeisterschaften','2019-04-30',42);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (7,'Bayerische Meisterschaften','2019-06-19',50);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (8,'Einsatz Medenspiel','2019-05-12',200);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (8,'Einsatz Medenspiel','2019-05-19',200);
INSERT INTO sport.claim (benefit_id,description,created_at,value) VALUES (8,'Siegprämie Medenspiel','2019-05-19',100);
