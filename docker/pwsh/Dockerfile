FROM fedora:rawhide

RUN dnf update -y \
	&& dnf install compat-openssl10 htop nano git -y \
	&& dnf install https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-rc.2/powershell-6.0.0_rc.2-1.rhel.7.x86_64.rpm -y \
	&& dnf clean all \
	&& mkdir data && cd data \
	&& git clone https://github.com/rogrwhitakr/HR.git \

COPY install.sh .

CMD /opt/microsoft/powershell/6.0.0-rc.2/pwsh
