# finding the files:
# 1. action files -> xml files, define what actions there are available
# 2. policy files -> js files, define policy (user with group wheel may do this and that, but if logged in via ssh restrictions xy apply,.... etc.)

# usually live in /usr/share/polkit-1/
sudo find / ( -name *.policy ) -or ( -name *.rules )
sudo find / ( -name *.policy ) -or ( -name *.rules )
sudo find / \( -name *.policy \) -or \( -name *.rules \)

# commandline actions

# list available actions
pkaction

# get more information
pkaction --verbose

# get only specific information
pkaction --action-id org.libvirt.api.domain.start --verbose

# pkexec
# pkexec erfüllt grundsätzlich die gleiche Aufgabe wie sudo, 
# d.h. es kann ein Programm mit Rechten eines anderen Nutzers ausgeführt werden. 
# Da pkexec die via PolKit definierten Regeln und Aktionen beachtet, ist eine wesentlich genauere bzw. fein-granularere Rechtesteuerung als mit sudo möglich.

