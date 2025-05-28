# creating an SMB (Samba) share on Fedora Linux 
 - involves installing the Samba server, 
 - configuring it, 
 - and setting up appropriate firewall rules 
 - and SELinux contexts.

---

**Step 1: Install Samba**

First, install the Samba server package (`samba`) and its client utilities (`samba-client`).

```bash
sudo dnf install samba samba-client -y
```

**Step 2: Configure the Samba Share**

This involves creating the directory you want to share and then editing the Samba configuration file (`smb.conf`).

1.  **Create the Shared Directory:**
    Let's create a directory called `myshare` in your home directory (or anywhere else you prefer).

    ```bash
    mkdir ~/myshare
    ```
    If you want it more globally accessible, you might put it in `/srv/samba/myshare` or similar. Adjust paths accordingly.

    ```bash
    sudo mkdir -p /srv/samba/myshare # Example for a public share
    sudo chown -R $USER:$USER /srv/samba/myshare # Give your user ownership
    sudo chmod -R 0775 /srv/samba/myshare # Set appropriate permissions
    ```

2.  **Edit `smb.conf`:**
    Open the main Samba configuration file for editing.

    ```bash
    sudo nano /etc/samba/smb.conf
    ```

    Scroll to the end of the file and add your share definition. Here are a few common examples:

    **Example 1: Public Read/Write Share (No Password, Accessible by Anyone on the Network)**
    * **Caution:** This is generally not recommended for sensitive data as it offers no security.

        ```ini
        [myshare]
            comment = My Public Samba Share
            path = /srv/samba/myshare
            browsable = yes
            writable = yes
            guest ok = yes
            read only = no
        ```

    **Example 2: Password-Protected Share for a Specific User (Recommended for Security)**
    * This is the more common and secure approach. You'll need to create a Samba user in Step 3.

        ```ini
        [myshare]
            comment = My Secure Samba Share
            path = /srv/samba/myshare
            browsable = yes
            writable = yes
            guest ok = no
            read only = no
            valid users = admin # Replace with your actual Linux username
        ```
        If you want multiple users, list them comma-separated: `valid users = user1, user2`.

    **Example 3: Share for a Specific Group**

    ```ini
    [myshare]
        comment = Group Share
        path = /srv/samba/myshare
        browsable = yes
        writable = yes
        guest ok = no
        read only = no
        valid users = @plex # Replace with your actual Linux group name (e.g., @plex group also holds user "admin")
        create mask = 0664
        directory mask = 0775
    ```

    **Explanation of Common Options:**

    * `[myshare]`: The name of your share as it will appear on the network.
    * `comment`: A description of the share.
    * `path`: The absolute path to the directory you want to share.
    * `browsable = yes`: Allows clients to see the share when Browse the network.
    * `writable = yes`: Allows clients to write to the share. (`read only = no` is equivalent).
    * `guest ok = yes`: Allows access without a username/password (public share).
    * `guest ok = no`: Requires authentication.
    * `valid users`: Specifies which users or groups can access the share. Use `@groupname` for groups.
    * `create mask`: Sets file permissions for newly created files.
    * `directory mask`: Sets directory permissions for newly created directories.

    Save and close the `smb.conf` file.

    **config used:**

    ```ini
    [data]
        comment = FILMS, SERIES, PHOTOS
        path = /mnt
        browsable = yes
        writable = yes
        guest ok = yes
        read only = no
        valid users = admin
    ```

**Step 3: Create Samba Users (if using password-protected shares)**

Samba has its own user database, separate from Linux system users. You need to create a Samba user and set a password for them. 
This user **must also exist as a system user** on your Fedora machine.

1.  **Add your Linux user to Samba:**

    ```bash
    sudo smbpasswd -a admin
    ```
    You will be prompted to set a Samba password for this user. This password can be different from their Linux login password.

**Step 4: Configure Firewall**

You need to allow Samba traffic through Fedora's firewall.

```bash
sudo firewall-cmd --add-service=samba --permanent
sudo firewall-cmd --reload
```

**Step 5: Configure SELinux**

SELinux (Security-Enhanced Linux) will by default prevent Samba from accessing arbitrary directories. You need to tell SELinux that your shared directory is allowed to be shared via Samba.

1.  **Set SELinux Context for the Shared Directory:**
    ```bash
    sudo semanage fcontext -a -t samba_share_t "/srv/samba/myshare(/.*)?"
    sudo restorecon -Rv /srv/samba/myshare
    ```
    Replace `/srv/samba/myshare` with the actual path to your shared directory.
    * `samba_share_t`: This is the SELinux type that allows Samba to share the directory.
    * `(/.*)?`: This part ensures that all subdirectories and files within `myshare` also get the correct context.
    * `restorecon -Rv`: Recursively applies the new SELinux context.

    **However, generally, creating a dedicated share directory like `/srv/samba/myshare` is cleaner for SELinux.**
2.  **i just deactivated SELinux for the time being....**

    ```bash
    sudo setenforce 0
    ```    


**Step 6: Start and Enable Samba Services**

Start the `smb` and `nmb` (NetBIOS name server) services and enable them to start automatically on boot.

```bash
sudo systemctl enable smb nmb
sudo systemctl start smb nmb
```

**Step 7: Verify Samba Status**

Check if the services are running:

```bash
sudo systemctl status smb nmb
```
You should see "active (running)".

---

**Step 8: Access the Share from a Client**

Now, from another computer on your network (Windows, macOS, Linux):

* **Windows:**
    * Open File Explorer.
    * In the address bar, type `\\your_fedora_ip_address\myshare` (e.g., `\\192.168.1.100\myshare`) and press Enter.
    * If prompted, enter the Samba username and password you created.

* **macOS:**
    * In Finder, go to `Go` > `Connect to Server...` (`Cmd + K`).
    * Type `smb://your_fedora_ip_address/myshare` and click `Connect`.
    * If prompted, enter the Samba username and password.

* **Linux (Nautilus/Files):**
    * Open your file manager.
    * Click "Other Locations" or "Connect to Server".
    * Type `smb://your_fedora_ip_address/myshare` and click `Connect`.
    * Enter credentials if required.
