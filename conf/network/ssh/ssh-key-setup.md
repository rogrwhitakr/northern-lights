# SSH Key Setup on new box

create or edit the config

```
touch ~/.ssh/config
nano ~/.ssh/config
```

own it and have permissions right

```
chown ${id -un} ~/.ssh/config
chmod 600 ~/.ssh/config
```

create a key pair with a name within the .ssh directory

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/<keyname>
```

copy the ssh key to all the boxes

```
ssh-copy-id -i ~/.ssh/<keyname>.pub <user>@<remote-box>
ssh-copy-id -i ~/.ssh/<keyname>.pub <remote-box-as-aliased-in-config>
```

done!
maybe edit the /etc/motd on the remote host to display hostname
maybe edit the .bashrc on the remote host to alter the color of the prompt
