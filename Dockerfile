FROM ubuntu:16.04
MAINTAINER Ryo Ota <nwtgck@gmail.com>

RUN apt update

# This is for apt-add-repository command
RUN apt install -y software-properties-common

# --- Start Install texlive --- #
# (http://qiita.com/seki0913/items/fe9a50ea11c716d76514)

RUN apt-add-repository ppa:texlive-backports/ppa
RUN apt install -y texlive-lang-cjk

# --- End Install texlive --- #

# ---- Start Install latexmk
RUN apt install -y latexmk
# ---- End Install latexmk


# ---- Start Install fonts
RUN apt install -y texlive-fonts-recommended
# ---- End Install fonts

RUN apt install -y pdf2svg
RUN apt install -y imagemagick

RUN apt install -y texlive-extra-utils 

COPY run-for-docker.bash /run-for-docker.bash
ENTRYPOINT [ "/run-for-docker.bash" ]