FROM nwtgck/latex
MAINTAINER Ryo Ota <nwtgck@gmail.com>

ADD run-for-docker.bash /run-for-docker.bash
CMD ./run-for-docker.bash