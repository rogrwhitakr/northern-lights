# [Documentation](https://docs.firefly-iii.org/how-to/firefly-iii/upgrade/self-managed/)

Created using composer "create-project"
The best way to upgrade is to "reinstall" Firefly III using the following command:

```
composer create-project grumpydictator/firefly-iii --no-dev --prefer-dist firefly-iii-updated 6.0.30
```

Where 6.0.30 is the latest version of Firefly III. This installs Firefly III in a new directory called firefly-iii-updated. Assuming your original Firefly III installation is in the directory firefly-iii you can upgrade by moving over your .env file and other stuff:


```
cp firefly-iii/.env firefly-iii-updated/.env
cp firefly-iii/storage/upload/* firefly-iii-updated/storage/upload/
cp firefly-iii/storage/export/* firefly-iii-updated/storage/export/
```

Then, run the following commands to finish the upgrade:

```
cd firefly-iii-updated
rm -rf bootstrap/cache/*
php artisan cache:clear
php artisan migrate --seed
php artisan firefly-iii:upgrade-database
php artisan passport:install
php artisan cache:clear
```

To ensure your webserver serves you the new Firefly III:


```
mv firefly-iii firefly-iii-old
mv firefly-iii-updated firefly-iii
```

If you get 500 errors or other problems, you may have to set the correct access rights:


```
sudo chown -R www-data:www-data firefly-iii
sudo chmod -R 775 firefly-iii/storage
```

dealing with the SELinux context stuff, relabeling etc.
did this for the ```data-importer```, unsure if it did anything, really...

```
[root@reese data-importer]
semanage fcontext -a -t httpd_sys_rw_content_t storage/logs
restorecon -v storage/logs
-> Relabeled /var/www/data-importer/storage/logs from unconfined_u:object_r:httpd_sys_content_t:s0 to unconfined_u:object_r:httpd_log_t:s0

```

## Data-Importer

The assumption is that you will install/upgrade the data importer in /var/www. 
but as composer does not seem to like being executed as root
1. go to home 
2. then download
3. then move
4. the chown to apache / nginx...

```
cd ~
composer create-project firefly-iii/data-importer --no-dev --prefer-dist data-importer 1.3.12

# as root
mv /var/www/data-importer /var/www/old-data-importer
mv data-importer/ /var/www/ 
cp /var/www/old-data-importer/.env /var/www/data-importer/.env
chown -R apache:apache data-importer
chmod -R 775 data-importer/storage
```

### upgrade

Instead of data-importer, use updated-data-importer.
This installs the tool in a new directory called updated-data-importer. 
Move over your .env file by copy-pasting it. 