# STK Garching API
## Start der API
API kann man mit dem CMD starten:  
```python3 api.py```

## Routen
### 1. Swagger Dokumentation
Beschriebung: Alle Infos zu API

`http://127.0.0.1:5000/swagger`

### 2. court_status
Beschreibung: Beschreibt den Status der Plätze zu einem bestimmten Zeitpunkt. Aktuell soll nur dargstellt werden ob der Platz gesperrt oder bespielbar ist.

`http://127.0.0.1:5000/court_status?date='2019-07-15 00:00:00'`

### 3. all_tasks
Beschreibung: Eine Liste aller Task.

`http://127.0.0.1:5000/all_tasks`

### 4. task_details
Beschreibung: Bei der Auswahl eines Task können zu diesem Detail Informationen  geladen werden.

`http://127.0.0.1:5000/task_detail?task_no=5`


### 5. benefit
Beschreibung: Jedes eingeloggte Mitglied kann seine Benefits sehen. Dazu muss das Mitglied eingeloggt sein.

`http://127.0.0.1:5000/benefit?members_no=1&valid_from='2019-01-01 00:00:00'&valid_to='2020-01-01 00:00:00'`

### 6. /contribution
Beschreibung: ToDo
