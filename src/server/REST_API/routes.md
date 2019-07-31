# Liste von möglichen Routen

1. benefit
Beschreibung: Jedes eingeloggte Mitglied kann seine Benefits sehen. Dazu muss das Mitglied eingeloggt sein. Beim einloggen wird dem Client die Mitgliedsnummer gesendet (Führende Datenquelle ist das Vereins CRM). Bei der Abfrage der REST API muss ein JWT übermittelt werden. Möglicherweise wird der JWT über https://auth0.com/de/

Route: https://api.stk-garching.de/benefit/

Parameter: member_no (NUMBER), valid_from (DATE), valid_to (DATE)

Queries: /database/sport/queries/benefit_per_player.sql

2. contribution
Beschreibung: Wie bei benefits nur dass Beteilgungen angezeigt werden. Das kann auch der Mitgliedsbeitrag sein.
Route https://api.stk-garching.de/contribution/

Queries: /database/sport/queries/contribution_per_player.sql

3. court_status
Beschreibung: Beschreibt den Status der Plätze zu einem bestimmten Zeitpunkt. Aktuell soll nur dargstellt werden ob der Platz gesperrt oder bespielbar ist.

Route: https://api.stk-garching.de/court_status/

Parameter: var_date (DATE)

Queries: /database/club/queries/court_status.sql

4. all_tasks
Beschreibung: Eine Liste aller Task. Möglicherweise muss man hier noch eine Einschränkung einbauen, oder inkrementelles Laden. Zu Beginn ist es bestimmt vertretbar eine komplette Liste zu laden. Darin werden alle möglichen Arbeiten auf der Anlage nachgehalten.

Route: https://api.stk-garching.de/tasks/

Queries: /database/club/queries/all_tasks.sql

5. task_details
Beschreibung: Bei der Auswahl eines Task können zu diesem Detail Informationen  geladen werden.

Route: https://api.stk-garching.de/task_detail/

Parameter: task_no (NUMBER)

Queries: /database/club/queries/task_details_comments.sql
/database/club/queries/task_details_persons.sql
