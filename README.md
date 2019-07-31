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
