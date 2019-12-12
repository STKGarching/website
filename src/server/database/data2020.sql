-- -------
-- Club --
-- -------

-- Person
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (1,TRUE,1,'Alexander','Satschko');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (2,TRUE,2,'Maximilian','Schmuck');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (3,TRUE,3,'Felix','Hutt');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (4,TRUE,4,'Marco','Mader');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (5,TRUE,5,'Christian','Blankl');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (6,TRUE,6,'Nikolas','Holzen');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (7,TRUE,7,'Florian','Grassl');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (8,TRUE,8,'Matvey','Khomentovsky');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (9,TRUE,9,'Luca','Corligano');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (10,TRUE,10,'Konstantin','Barth');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (11,TRUE,11,'Fabian','Patrutescu');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (12,TRUE,12,'Lukas','Kortus');
INSERT INTO `club`.`person` (person_no,is_member,member_id,first_name,last_name) VALUES (13,TRUE,13,'Simon','Walter');

-- --------
-- Sport --
-- --------

-- Players
INSERT INTO `sport`.`player` (member_no) VALUES (1);
INSERT INTO `sport`.`player` (member_no) VALUES (2);
INSERT INTO `sport`.`player` (member_no) VALUES (3);
INSERT INTO `sport`.`player` (member_no) VALUES (4);
INSERT INTO `sport`.`player` (member_no) VALUES (5);
INSERT INTO `sport`.`player` (member_no) VALUES (6);
INSERT INTO `sport`.`player` (member_no) VALUES (7);
INSERT INTO `sport`.`player` (member_no) VALUES (8);
INSERT INTO `sport`.`player` (member_no) VALUES (10);
INSERT INTO `sport`.`player` (member_no) VALUES (11);
INSERT INTO `sport`.`player` (member_no) VALUES (12);
INSERT INTO `sport`.`player` (member_no) VALUES (13);

-- Teams
INSERT INTO `sport`.`team` (team_name,season,valid_from,valid_to) VALUES ('Herren 30 1','Sommerrunde 2020','2019-10-01 00:00:00','2020-09-30 23:59:59');
INSERT INTO `sport`.`team` (team_name,season,valid_from,valid_to) VALUES ('Herren 1','Sommerrunde 2020','2019-10-01 00:00:00','2020-09-30 23:59:59');

-- Team Members
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (1,1,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (1,2,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (1,3,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (1,4,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (1,5,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (1,6,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,7,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,8,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,9,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,10,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,11,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,12,true);
INSERT INTO `sport`.`team_members` (team_id,player_id,is_main_team) VALUES (2,13,true);

-- Benefit
-- Herren 30
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,1,'team','Doppelstunde Halle - Training Herren 30 Dienstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,1022,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (3,1,'team','Trainer 1h - Training Herren 30 Dienstag','2019-10-01 00:00:00','2020-04-20 23:59:59',25,1,40,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,1,'team','Doppelstunde Halle - Training Herren 30 Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,964,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,1,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,2,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,3,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,4,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,5,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,6,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,1,'team','Trainingsbälle (Dunlop Trainer) Winter Dienstag','2019-10-01 00:00:00','2020-04-20 23:59:59',18,2,7.3,NULL,false);
-- INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,1,'team','Trainingsbälle (Dunlop Trainer) Winter Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',18,2,7.3,NULL,false);
-- INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,1,'team','Trainingsbälle (Wilson DTB Tour) Sommer Dienstag','2020-04-01 00:00:00','2020-09-30 23:59:59',36,2,10.95,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (8,1,'team','Mannschaftsessen','2019-10-01 00:00:00','2020-04-20 23:59:59',3,3,90,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (9,1,'team','Schiedsrichter Bundesliga','2019-10-01 00:00:00','2020-04-20 23:59:59',3,3,800,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (10,1,'team','Hotel- und Reisekosten Auswärtsspiele','2019-10-01 00:00:00','2020-04-20 23:59:59',3,3,800,NULL,false);
-- Hallenplatz für Individualtraining (Alex, Maxi, Felix, Marco, Christian, Niko)
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,1,'player','2 Hallenstunden pro Woche','2019-10-01 00:00:00','2020-04-20 23:59:59',50,1,17,NULL,true);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,2,'player','2 Hallenstunden pro Woche','2019-10-01 00:00:00','2020-04-20 23:59:59',50,1,17,NULL,true);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,3,'player','2 Hallenstunden pro Woche','2019-10-01 00:00:00','2020-04-20 23:59:59',50,1,17,NULL,true);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,4,'player','2 Hallenstunden pro Woche','2019-10-01 00:00:00','2020-04-20 23:59:59',25,1,17,NULL,true);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,5,'player','2 Hallenstunden pro Woche','2019-10-01 00:00:00','2020-04-20 23:59:59',25,1,17,NULL,true);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,6,'player','2 Hallenstunden pro Woche','2019-10-01 00:00:00','2020-04-20 23:59:59',50,1,17,NULL,true);

-- Herren
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,2,'team','Doppelstunde Halle - Training Herren Dienstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,1022,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (3,2,'team','Trainer 1h - Training Herren Dienstag','2019-10-01 00:00:00','2020-04-20 23:59:59',25,1,40,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,2,'team','Doppelstunde Halle - Training Herren Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,964,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,7,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,8,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,9,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,10,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,11,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,12,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (2,13,'player','Eigenanteil Halle Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',1,4,-75,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,2,'team','Trainingsbälle (Dunlop Trainer) Winter Dienstag','2019-10-01 00:00:00','2020-04-20 23:59:59',36,2,7.3,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,2,'team','Trainingsbälle (Dunlop Trainer) Winter Samstag','2019-10-01 00:00:00','2020-04-20 23:59:59',36,2,7.3,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (1,2,'team','Trainingsbälle (BTV Ball) Sommer Dienstag','2020-04-01 00:00:00','2020-09-30 23:59:59',36,2,12,NULL,false);
INSERT INTO `sport`.`benefit` (benefit_type_id,entity_id,entity,description,valid_from,valid_to,count,amount_id,value,cap_sum_value,is_claimable) VALUES (8,2,'team','Mannschaftsessen','2019-10-01 00:00:00','2020-04-20 23:59:59',6,3,90,NULL,false);
-- Hallenplatz für Individualtraining (Matvey, Konsti, Luca, Simon, Lukas, Flo)
-- Turniere zahlen (Konsti, Luca, Simon, Lukas)
