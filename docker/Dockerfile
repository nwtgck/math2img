FROM ubuntu:16.04
LABEL maintainer="Ryo Ota <nwtgck@gmail.com>"

# This is for apt-add-repository command
RUN apt update && apt install -y software-properties-common

# --- Start Install texlive --- #
# (http://qiita.com/seki0913/items/fe9a50ea11c716d76514)
RUN apt-add-repository ppa:texlive-backports/ppa
RUN apt install -y \
        texlive-lang-cjk \
        latexmk \
        texlive-fonts-recommended \
        texlive-extra-utils \
        pdf2svg \
        imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


COPY run-for-docker.bash /run-for-docker.bash
ENTRYPOINT [ "/run-for-docker.bash" ]
