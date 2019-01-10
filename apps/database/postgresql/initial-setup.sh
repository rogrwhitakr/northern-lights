how does that damn setup work again mkdir ~/MyScripts/apps/postgresqlmkdir ~/MyScripts/apps/postgresql!

# install postgres
# -> Follow steps for your OS.

# typically initdb creates a table named "postgres" owned by user "current logged in user name"
/usr/bin/initdb -D /var/lib/pgsql/data -U postgres

# steps after installation and init
# First connect/login as root / admin / wheel
su - postgres

# should prompt straight to psql
# gave postgres user a password, need to authenticate first
sudo su - postgres ???

# once connected -> help comme ca
postgres=#  help

# Create schema in the default database called postgres
CREATE SCHEMA <schema>;

# Create a role (user) with password
CREATE USER <user> PASSWORD '<password>';

# Grant privileges (like the ability to create tables) on new schema to new role
GRANT ALL ON SCHEMA <schema> TO <user>;

# Grant privileges (like the ability to insert) to tables in the new schema to the new role
GRANT ALL ON ALL TABLES IN SCHEMA <schema> TO <user>;

# Disconnect
\q

The default authentication mode is set to 'ident' which means a 
given Linux user <user> can only connect as the postgres user <user>.

# Login from <user> user in shell to default postgres db
sudo su - <user>

# this should also do it. if set up correctly i assume...
su postgres 

# Create a table <table> in schema <schema>
CREATE TABLE <table>.<schema> (col<schema> varchar(20));

# Insert a single record into new table
insert into <table>.<schema> (col<col>) values ('It works!');