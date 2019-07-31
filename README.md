# Get website running

Follow these instructions to get the website running on your dev system:
1. Set up database. [See this section](#Database) for detailed installation hints.

# Backend
## Database
### Installation
**The following information are for setting up and running the database on a raspberry pi**

1. Install mySQL Database and setup a user: [Tutorial](https://www.stewright.me/2014/06/tutorial-install-mysql-server-on-raspberry-pi/)
2. In order to use the custom install script set up a my.cnf file (Keep in mind, this is not secure but suitable for development): [Simple Tutorial](https://easyengine.io/tutorials/mysql/mycnf-preference/)
3. The DDL scripts for tables, functions and procdures as well as sample Data Input can be found in src/server. To setup the DB one can install the project files.  
  3.1. Project files contain a list of DDL script files. Comment lines need a #-prefix. They have the folling naming convention (regex): P\d{4}.conf  
  3.2. Project files can be installed with the install script: install.sh ;it needs an argument which has the format \d+ ;The digit stands for the project filed number, e.g. 2 ist for P0002.conf

**Install first data model**

Create two new schemas (DDLs are not written yet):
* sport
* club

Initial installation of all tables, procedures and functions.
```
install.sh 1
```

Installation of sample data
```
install.sh 2
```

### File structure
**src/server/**
Installation file and project files

**src/server/club and src/server/sport**
schema related folder with subfolders:
* **tables**: containing all scripts for table creation and consecutive procedures
* **functions**: containing all scripts for function creation
* **queries**: all queries for REST API

### ERR Model
**diagram**
```diff
- diagramm does not fit 100% correctly to DDL scripts. Will be corrected soon!
```
![Diagram](https://github.com/STKGarching/website/blob/master/STK_ERR.png)

**explanation**
This is a first short explanation. Not finished yet:  

**sport**  
__benefits__ are can be anything which gives (in generall monetary) advantages for players and teams. A normal benefit like a trainer for a team has the following setup: _is_claimable_ is false, _cap_sum_value_ is null, _value_ is not null.  
There are benefits with and upper monetary limit: This means _is_claimable_ is true, _cap_sum_value_ is not null, _value_ is null
Those benefits must be claimed (see the table __claim__) which means the player must bring a bill and then gets the refund, e.g. tournament fee.  
There are benefits where the player or team has to contribute (sse table __contribution__) a small monetary amount.

**club**
The court status can be monitored. First application is the status due to weather conditions. Upcoming features are possible but will not implemented in first stage.  
"Arbeitsdienst" should be organised by a task list (similar to JIRA)
