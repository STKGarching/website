SET @var_court_id:=1;
SET @var_court_status_list_id:=3; /* Gesperrt */
SET @var_valid_from:='2020-07-15 00:00:00';
SET @var_valid_to:=NULL;
SET @var_changed_by:='ben';

CALL club.p_court_status_insert(@var_court_id,@var_court_status_list_id,@var_valid_from,@var_valid_to,@var_changed_by);
