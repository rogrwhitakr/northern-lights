

# NORTHERNLIGHTS

<h1 align="center">
	<br>
	<img width="200" src="https://cdn.rawgit.com/sindresorhus/awesome/master/media/logo.svg" alt="awesome">
	<br>
</h1>

<h3>Index</h3>
<ul>
<li><a href="#BASHRC">.bashrc | .bash_profile</a></li>
<li><a href="#TODO">TODOs</a></li>
<li><a href="#DONE">done elements</a></li>
<li><a href="#CHECK">CHECK</a></li>
<li><a href="#WHAT">WHAT</a></li>
<li><a href="#WHY">WHY</a></li>

<li><a href="#COREUTILS">COREUTILS</a></li>
<li><a href="#APACHE">APACHE</a></li>
<li><a href="#BORG">BORG</a></li>
</ul>

## BASHRC

Set up the BASH CLI with all aliases, functions, etc. => execute:

```bash
wget https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/script/setup-profile-on-new-box.bash 

chmod u+x ./setup-profile-on-new-box.bash

./setup-profile-on-new-box.bash
```

## SSH

Set up a basic ssh config file (no keys) => execute:

```bash
wget https://raw.githubusercontent.com/rogrwhitakr/northern-lights/master/conf/network/ssh/create-ssh-profile.sh 

chmod u+x ./create-ssh-profile.sh

./create-ssh-profile.sh
```

### CHECK:
- screen 
- chubby / Zookeeper lock service

### WHAT?
- what is webrick exactly?
- what is "rake" exactly?
- what is inetd


### WHY?
- copying a file from home to root-owned directory /var/www/html makes root the owner? Even if apache user - owns the directory and my user is part of the apache group?

### COREUTILS
- how do i get the owner of the file in uid and guid ids?
- find -perm setuid-bit, like on /bin/login program

### APACHE
- How do you measure webserver performance / load? 
  - If i use a memcached service layer, how do i initially decide i need one?
  - explainer for mime.types
- Load balancing
- Common Gateway Interface
- CGI programs serve HTML data dynamically based on input passed to them

### BORG:
- how to put backup back into play?
- TODO: extraction script, using the latest backup (or one that can be chosen?)

# DONE:
- install sql workbench -> ansible
- what is dbus-broker? -> dbus broker in userspace
- install plotinus -> done in HS, works well (for some programs like nautilus). must be compiled
### SYSADMIN
- is it good practice in bash to let traps handle different error conditions, like example?
- local engineering plan -> get a demo one
- service request model (SRM) -> demo one also
- gnome reverse polarity,night vision. same for chrome browser...
- what is switch root service?
- configuration management database (CMDB) provider? capabilities? cost? -> there are a lot (serviceNOW for example, and a lot more)
### ANSIBLE
- can ansible do the extension installation for vscode?
# TODO:
- systemd cpu cycle control elements => borg consumes everything it can
- have the web server deliver a wiki
- what is systemd-nspawn?
- what is busy-box?
- install decode-dimms for trials
- assign static addresses to VM(s) using dnsmasq, while they are ste to dhcp mode/ reserved IPs....
- nac solution vendors. which are there? what do they offer? open source solutions?
- how do you explore python builtins??? how to use???
- reveal.js what is it?