FROM gentoo/portage:latest as portage
FROM gentoo/stage3-amd64:latest
COPY --from=portage /usr/portage /usr/portage

MAINTAINER Eric Gazoni <eric.gazoni@adimian.com>

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV PYTHONIOENCODING=utf8
ENV ACCEPT_KEYWORDS="~amd64"

RUN emerge -q --sync
# RUN emerge -q --update @world
RUN emerge -q dev-util/ccache

RUN emerge -q dev-lang/python:2.7
RUN emerge -q dev-lang/python:3.4
RUN emerge -q dev-lang/python:3.5
RUN emerge -q dev-lang/python:3.6
RUN emerge -q dev-lang/python:3.7
# RUN emerge -q dev-python/pypy
# RUN emerge -q dev-python/pypy3
RUN emerge -q dev-python/tox
RUN emerge -q dev-vcs/git

ADD clean-launch.sh /tools/clean-launch.sh

ADD passwd.minimal /etc/passwd.ext
RUN cat /etc/passwd.ext >> /etc/passwd
USER me

VOLUME /source
WORKDIR /source

ENTRYPOINT ["/tools/clean-launch.sh"]
CMD ["tox", "--skip-missing-interpreters"]
