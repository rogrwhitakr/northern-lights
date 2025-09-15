
# all entries using dnf command 
journalctl _COMM=dnf
journalctl _COMM=dnf5

journalctl _COMM=dnf5 --grep="Installed\|Upgraded" --since "30 days ago" -o verbose

# all entries using the automatic timer
journalctl --unit=dnf5-automatic.service