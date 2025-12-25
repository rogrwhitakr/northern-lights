
# install postgresql-server 

- [Link-to-fedora-docs](https://docs.fedoraproject.org/en-US/quick-docs/postgresql/)

# initialize

- [Link-to-fedora-docs](https://docs.fedoraproject.org/en-US/quick-docs/postgresql/)

## process

1. initdb creates a table named "postgres" owned by user "current logged in user name"

```
/usr/bin/initdb -D /var/lib/pgsql/data -U postgres

```

2. enabling the service and failing to start provides also the steps to do:
 1. change to user postgres
 2. run the command (initdb)

3. steps after installation and init
 1. First connect/login as root / admin / wheel, change postgres user password:

 ```bash
sudo passwd postgres
 ```
  2. change psql postgres password

  ```sql
    ALTER USER postgres WITH PASSWORD 'postgres';
  ```

# should prompt straight to psql
# gave postgres user a password, need to authenticate first
sudo su - postgres ???

# once connected -> help comme ca
postgres=#  help

# how to change the postgres (unix) user password (disabled by default): metacommand \password
postgres=\password

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

## pg_hba.conf

```ini
# To allow all users from the subnet 192.168.10.0 with a /24 mask to access all databases using SCRAM-SHA-256 authentication, you would add the following line:
host    all             all             192.168.178.0/24       scram-sha-256
```