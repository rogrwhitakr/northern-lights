FROM fedora

RUN dnf update -y 	&& dnf install wine -y 	&& dnf clean all

ENV DISPLAY :0

VOLUME /tmp/.X11-unix/X0

CMD /bin/bash
