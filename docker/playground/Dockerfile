FROM fedora:rawhide

LABEL vendor=io.northernlights

ENV VERSION=0.1.0

RUN dnf update -y && dnf install -y nano find && dnf clean all

CMD /bin/bash
