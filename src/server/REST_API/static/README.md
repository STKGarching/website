# STK Garching API
## Start der API
API kann man mit dem CMD starten:  
```python3 api.py```

## Routen
### 1. Swagger Dokumentation
Beschriebung: Alle Infos zu API

`http://127.0.0.1:5000/swagger`

### 2. get_court_status
Beschreibung: Beschreibt den Status der Plätze zu einem bestimmten Zeitpunkt. Aktuell soll nur dargstellt werden ob der Platz gesperrt oder bespielbar ist.

`http://127.0.0.1:5000/get_court_status?date='2019-07-15 00:00:00'`

### 3. get_all_tasks
Beschreibung: Eine Liste aller Task.

`http://127.0.0.1:5000/get_all_tasks`

### 4. task_details
Beschreibung: Bei der Auswahl eines Task können zu diesem Detail Informationen  geladen werden.

`http://127.0.0.1:5000/task_detail?task_no=5`

### 5. benefit
Beschreibung: Jedes eingeloggte Mitglied kann seine Benefits sehen. Dazu muss das Mitglied eingeloggt sein.

`http://127.0.0.1:5000/benefit?members_no=1&valid_from='2019-01-01 00:00:00'&valid_to='2020-01-01 00:00:00'`

### 6. contribution
Beschreibung: ToDo

### 7. add_person
Beschreibung: Jedes Mitglied kann hinzugefügen.

`http://localhost:5000/add_person?person_no=99&is_member=true&member_no=99&first_name=Test_Name&last_name=Test_Nachname`

### 8. person_info
Beschreibung: Person informationen abrufen

`http://127.0.0.1:5000//person_info?person_no=99`

### 9. Court status liste
Beschreibung: Liefert den Status der Plätze

`http://127.0.0.1:5000/court_status_list`

### 10. Add court
Beschreibung: Ein Platz hinzufügen

`http://localhost:5000/add_court?court_id=2&court_no=2&court_surface=Hardplatz&court_type=Freiplatz&valid_from=2019-01-01 00:00:00&valid_to=2019-01-01 00:00:00&modified_at=&changed_by=Sred`

### 11. Get court status for date
Beschreibung: Liefert den Status aller Plätze für ein bestimmtes Datum

`http://127.0.0.1:5000/get_court_status_date?date='2019-07-15 00:00:00'`

### 12. Add court status
Beschreibung: Status des Platzes hinzufügren

`http://localhost:5000/add_court_status?court_id=2&court_status_list_id=2&valid_from=2019-01-01 00:00:00&valid_to=2019-01-01 00:00:00&modified_at=&changed_by=Sred`

### 13. Get court status list
Beschriebung: Liefert mögliche Platzstatus zurück

`http://localhost:5000/get_court_status_list`

### 14. Get court status now
Beschriebung: Liefert jetztigen Status der Plätze

`http://localhost:5000/get_court_status_now`

### 15. Get personen info
Beschriebung: Liefert personen info

`http://localhost:5000/get_personen_info?person_no=9`

### 16. Get task comments
Beschriebung: Liefert kommentare eines Tickets

`http://localhost:5000/get_task_comments?task_no=2`
