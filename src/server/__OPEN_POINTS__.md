# Offene Punkte Datenbank und REST API
## Speichern bei dynamischer Anzahl von Entitäten.

Beispiel:
Es wird ein Task mit database/club/queries/task_add.sql erstellt. In der GUI wird der User nach dem erstellen in eine Maske zur Bearbeitung des Tasks weitergeleitet. Hier kann er z.B. mehrere Bearbeiter eintragen oder mehrere Bilder hochladen. Technisch wird pro Bearbeiter ein Eintrag in der Tabelle club.relationship erstellt, bzw. pro Bild wird ein Eintrag in club.image und in club.relationship erstellt.

Problem:
Der User könnte die Prozedur abbrechen und den Task unbearbeitet lassen. D.h. eigentlich möchte ich die Änderungen am Task erst dann in die Datenbank schreiben, wenn der User auf speichern drückt. Davor werden die Daten erstmal nur auf dem Client vorgehalten (Redux Store).
Wenn der User also speichern drückt muss ich eine dynamische Anzahl an z.B. Bildern in die Datenbank schreiben. Ich will aber nicht, dass etwas dabei verloren geht, idealerweise schicke ich also
alles als gesamtes Paket an die REST API.

1. Das könnte zu ziemlich vielen Parameter führen. Ist das so üblich? Oder schickt man evtl. eher ein JSON mit den Parametern im HTTPS Request an die REST API?
2. Werden die Einträge für die Entitäten über eine Schleife in der REST API behandelt oder soll das erst im SQL Statement stattfinden? z.B. mit einem CONNECT BY?

Lösung: ?

## SQL Statements und Routen verwalten

Status Quo:
Die Routen werden in der Datei server/REST_API/static/swagger.json verwaltet
Die Queries existeren in server/database/... und werden redunant in server/REST_API/stk_api/api.py gehalten.

Problem:
Gibt es eine Möglichkeit alls zusammen an einem Ort zu verwalten? Oder zumindest die Redundanz der SQL Queries aufzulösen?

Lösung: ?

## Auth0 einbinden; Wer darf welche Daten sehen und wie kann man das managen?

Problem:
1. Wie kann sicher gestellt werden dass bei einer REST API Abfrage nur registrierte Nutzer eine Datenlieferung erhalten?
2. Wie wird sicher gestellt, dass der User für den REST API Request authentifiziert ist? Der reine Access Token (JWT) reicht hier nicht aus. Es müsst eigentlich noch mittels Datenbank geprüft werden welche Rolle der User hat und ob die Rolle das betroffene SQL ausführen darf.
Beispiel: In der Weboberfläche könnte ein böser User die source files clientseitig so anpassen, dass er Admin Bereiche sehen kann. Das sollte aber nicht dazu führen, dass er die Daten dieser Seiten auch erhält.

Lösung:
1. Teil:
Nutzung von Auth0: Der User liefert mit dem Request einen Access Token (JWT) mit.

2. Teil: ?

## changed_by handeln

Beispiel:
Wenn in club.court_status - eine Tabelle mit Zeitreihe; d.h. es gibt ein changed_by Feld - der Status eines Platzes geändert wird dann wird der Bearbeiter in changed_by vermerkt.

Problem:
Was soll her genommen werden? die person_id?
Soll für jeden App User auch eine Datenbank User angelegt werden?
Wie kann ich sicher sein, dass der User mir die richtige person_id liefert? Wenn die Website Lösung schlecht gebaut ist dann könnte der Client die ID manuell ändern.

Lösung:
Es wird die person_no genommen. Dieses Feld wird bei der Registierung über Auth0 mit der Auth-userid befüllt. Diese ID kann man im Access Token unter dem key "sub" finden. dadurch kann
bei allen Abfragen bei denen eine Authentifizierung des User notwenig ist, immer die userid aus dem Token genommen werden. Somit wird sichergestellt, dass der User berechtigt ist auf die REST API zuzugreifen und auch, welcher User es ist.
