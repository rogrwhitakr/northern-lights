FROM fedora:rawhide
# Add metadata
LABEL vendor=io.northernlights

# The version of PWSH to be installed
ENV PWSH_VERSION=6.0.1

RUN dnf update -y && dnf install -y \
	compat-openssl10 \ 
	htop \
	nano \
	sudo \
	wget \
	https://github.com/PowerShell/PowerShell/releases/tag/v${PWSH_VERSION}/powershell-${PWSH_VERSION}-1.rhel.7.x86_64.rpm && \
	dnf clean all

WORKDIR /pwsh/

COPY PS/profile /root/.config/powershell/Microsoft.PowerShell_profile.ps1 

CMD /opt/microsoft/powershell/${PWSH_VERSION}/pwsh