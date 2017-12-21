FROM fedora:rawhide

RUN dnf update -y \
    && dnf install nmap traceroute whois htop nano -y \
    && dnf clean all

# glances stuff doesnt work like this
#RUN curl -L https://raw.githubusercontent.com/nicolargo/glancesautoinstall/master/install-develop.sh | /bin/bash && rm -rf /var/lib/apt/lists/*
# Define working directory.
# WORKDIR /glances
# EXPOSE PORT (For XMLRPC)
#EXPOSE 61209
# EXPOSE PORT (For Web UI)
#EXPOSE 61208
# Define default command.
#CMD python -m glances -C /glances/conf/glances.conf $GLANCES_OPT

CMD /bin/bash