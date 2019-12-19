# Get website running

Follow these instructions to get the website running on your dev system:
1. Set up database. [See this section](#Database) for detailed installation hints.
2. Handle REST API: [See this section](#REST API)
3. Set up Frontend. [Installation](#Installation) can be found here.
4. Configure Webserver. In this case [Apache2](Apache Webserver).
5. Run Website in DEV SERVER Mode: [here](#DEV SERVER).

# Frontend
## Prototyp
You can find a prototyp [here](https://marvelapp.com/55c77je). Prototype shows functionality of the Progressive Web App.

## Installation
1. Get [yarn package](https://www.npmjs.com/package/yarn)
2. install all dependencies in base Folder:
```
yarn install
```
3. Add file in /src/client/app/helpers/ with the name auth0-variables.js
Content should be:
```
export const AUTH_CONFIG = {
  domain: '{auto0 domain}',
  clientId: '{auto0 clientId}',
  audience: '{auto0 audience}',
  callbackUrl: '{auto0 callbackUrl}'
}
```
domain and clientId can be found in Auth0 Account (see also next step for configuration). audience and callback are the dev website URLs.
4. Configure Auth0 Application (contact Benni). Provide your URL for this step.

## DEV SERVER
Before starting the dev website, handle this point [Apache2](Apache Webserver).
Start DEV server with
```
yarn run dev-server
```

The Webpack dev server has a hot reloading module. You can change the code and the website will be reloaded automatically.

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

**src/server/database/club and src/server/database/sport**
schema related folder with subfolders:
* **tables**: containing all scripts for table creation and consecutive procedures
* **functions**: containing all scripts for function creation
* **queries**: all queries for REST API

### ERR Model
**diagram**
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

## REST API
Find more infos at /src/server/REST_API/static/README.md

Start API in folder /src/server/REST_API/stk_api with  
```
python3 api.py
```

## Apache Webserver
The dev website (i.e. with Weboack Dev Server) and the REST API backend are running on localhost with different ports. In order to access the dev website from your home network, set up the apache webserver on your server machine and provide the dev website via Proxy Reverse.
You need the following module:
* mod_ssl
* mod_rewrite
* mod_proxy

If you provide the REST_API with a SSL certificate, you have to set it up. In the following .htaccess file it is implemented though it should not be neccessary.
With the following .htaccess file you can set up the Proxy paths. It can be configured in /etc/apache2/sites-available/{your config file}.conf.

```
<IfModule mod_ssl.c>
  <VirtualHost {YOUR_SERVER_IP}:443>
    ServerName {YOUR_SERVER_NAME}
    DocumentRoot /var/www/html/

    SSLEngine On
    SSLCertificateFile /etc/letsencrypt/live/mirrorpi.ddns.net/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/mirrorpi.ddns.net/privkey.pem

    ProxyRequests On

    ProxyPass /stkapi http://127.0.0.1:5000
    ProxyPassReverse /stkapi http://127.0.0.1:5000
  </VirtualHost>

</IfModule>

<VirtualHost {YOUR_SERVER_IP}:80>
  ServerName {YOUR_SERVER_NAME}
  DocumentRoot /var/www/html

  # Enable the rewrite engine
  # Requires: sudo a2enmod proxy rewrite proxy_http proxy_wstunnel
  # In the rules/conds, [NC] means case-insensitve, [P] means proxy
  RewriteEngine On

  # STK API
  RewriteCond %{REQUEST_URI}  stkapi                   [NC]
  RewriteCond %{QUERY_STRING} transport=polling        [NC]
  RewriteRule /(.*)           http://127.0.0.1:5000/$1 [P]

  # socket.io 1.0+ starts all connections with an HTTP polling request
  # Use this for hot reloading!
  RewriteCond %{QUERY_STRING} transport=polling       [NC]
  RewriteRule /(.*)           http://127.0.0.1:9000/$1 [P]
  RewriteCond %{HTTP:Upgrade} websocket               [NC]
  RewriteRule /(.*)           ws://127.0.0.1:9000/$1  [P]

  ProxyPass / http://127.0.0.1:9000/
  ProxyPassReverse / http://127.0.0.1:9000/

</VirtualHost>

```
