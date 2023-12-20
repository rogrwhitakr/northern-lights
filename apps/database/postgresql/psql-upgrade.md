# after system upgrade fedora 27 -> 39 
## postgresql-server fails

```
Dez 12 15:03:25 reese systemd[1]: Starting postgresql.service - PostgreSQL database server...
Dez 12 15:03:31 reese postgresql-check-db-dir[1582]: An old version of the database format was found.
Dez 12 15:03:31 reese postgresql-check-db-dir[1582]: Use 'postgresql-setup --upgrade' to upgrade to version '15'
Dez 12 15:03:31 reese postgresql-check-db-dir[1582]: See /usr/share/doc/postgresql/README.rpm-dist for more information.
Dez 12 15:03:26 reese systemd[1]: postgresql.service: Control process exited, code=exited, status=1/FAILURE
Dez 12 15:03:26 reese systemd[1]: postgresql.service: Killing process 1609 (postgresql-chec) with signal SIGKILL.
Dez 12 15:03:26 reese systemd[1]: postgresql.service: Failed with result 'exit-code'.
Dez 12 15:03:26 reese systemd[1]: Failed to start postgresql.service - PostgreSQL database server.
```

use the postgres user

```
sudo su - postgres
```

execute

```
postgresql-setup --upgrade
 * Upgrading database.
 * Upgraded OK.


WARNING: The configuration files were replaced by default configuration.
WARNING: The previous configuration and data are stored in folder
WARNING: /var/lib/pgsql/data-old.
```

cleanup

```
-> configuration must be amendend in
-> postgresql.conf
-> pg_hba.conf
```