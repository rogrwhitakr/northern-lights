FROM fedora

RUN dnf update -y 	&& dnf install nmap traceroute whois htop nano -y 	&& dnf clean all

CMD /usr/bin/nmap -v -A gil.ot.local

