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

