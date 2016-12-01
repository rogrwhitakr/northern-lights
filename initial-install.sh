# /bin/sh
clear
echo
echo update system
echo
dnf update -y
echo
echo Install coreutils GUI
echo
dnf install htop nano chromium.x86_64 chromium-native_client.x86_64 -y
echo
echo Install network tools
echo
dnf install whois.x86_64 wireshark.x86_64 wireshark-devel.x86_64 wireshark-cli.x86_64 wireshark-qt.x86_64 iperf3.x86_64 -y
echo
echo Install Docker
echo
dnf install docker.x86_64 docker-client.noarch docker-selinux.x86_64 docker-compose.noarch -y
