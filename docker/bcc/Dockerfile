FROM fedora:rawhide

LABEL vendor=io.northernlights

RUN dnf update -y \
    && dnf install bcc-tools -y \
    && dnf clean all

CMD /bin/bash