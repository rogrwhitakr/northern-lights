FROM fedora:rawhide

# https://opensource.com/article/17/11/bccbpf-performance
LABEL vendor=io.northernlights

RUN dnf update -y \
    && dnf install bcc-tools -y \
    && dnf clean all

WORKDIR /usr/share/bcc/tools/

CMD /bin/bash