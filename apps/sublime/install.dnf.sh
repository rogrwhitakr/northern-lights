# Install the GPG key:
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

# Select the channel to use: Stable
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

# Update dnf and install Sublime Text
sudo dnf install sublime-text -y