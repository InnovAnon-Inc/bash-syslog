FROM ubuntu as build

ARG DEBIAN_FRONTEND=noninteractive

COPY dist/ /tmp/dist/

    #/tmp/dist/bash-static*.deb     \
RUN apt update                     \
&&  apt full-upgrade -y            \
    --no-install-recommends        \
&&  apt install      -y            \
    --no-install-recommends        \
    /tmp/dist/bash_*.deb           \
    /tmp/dist/bash-builtins*.deb   \
    less                           \
    vim                            \
&&  apt autoremove   -y            \
    --purge                        \
&&  apt clean        -y            \
&&  rm -rf  /var/lib/apt/lists/*   \
&&  rm -rfv /tmp/dist/

VOLUME ["/root"]

RUN test -x  /usr/bin/env
ENTRYPOINT ["/usr/bin/env", "bash", "-i"]

