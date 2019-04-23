# build using: docker build pwsh/ --tag pwsh:[version]
FROM fedora:27

# Add metadata
LABEL vendor=io.northernlights

# The version of PWSH to be installed
ENV PWSH_VERSION=6.0.1

# OpenSSL toolkit provides support for secure communications between machines
RUN dnf update -y && dnf install -y \
	compat-openssl10 \ 
	htop \
	nano \
	wget \
	https://github.com/PowerShell/PowerShell/releases/download/v${PWSH_VERSION}/powershell-${PWSH_VERSION}-1.rhel.7.x86_64.rpm && \
	dnf clean all

# work environement
WORKDIR /pwsh/
VOLUME /core

COPY PS/profile /root/.config/powershell/Microsoft.PowerShell_profile.ps1 

CMD /opt/microsoft/powershell/${PWSH_VERSION}/pwsh