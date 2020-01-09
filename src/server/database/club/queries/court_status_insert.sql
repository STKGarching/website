SET @var_court_id:=1;
SET @var_court_status_list_id:=3; /* Gesperrt */
SET @var_valid_from:='2020-07-15 00:00:00';
SET @var_valid_to:=TIMESTAMPTZ '9999-12-31 23:59:59';
SET @var_modified_at:=NOW();
SET @var_changed_by:='ben';

INSER INTO club.court_status (court_id,court_status_list_id,valid_fromvalid_to,modified_at,changed_by)
VALUES (@var_court_id,@var_court_status_list_id,@var_valid_from,@var_valid_to,@var_modified_at,@var_changed_by);
