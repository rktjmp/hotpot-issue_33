FROM debian:buster-slim

RUN apt update
RUN apt install -y git curl zip unzip python3 python3-pip libpcre2-dev
RUN pip3 install hererocks
RUN hererocks /opt/here --luarocks ^ --luajit ^
ENV PATH /opt/here/bin:$PATH
RUN luarocks install lrexlib-PCRE2

RUN cd /root && curl -LO https://github.com/neovim/neovim/releases/download/v0.5.0/nvim-linux64.tar.gz
RUN cd /root && tar xzf nvim-linux64.tar.gz
ENV PATH /root/nvim-linux64/bin:$PATH

COPY config /root/.config/nvim
COPY fennel-test /root/fennel-test

WORKDIR /root
RUN cd fennel-test/libfennel \
  && make
ENV PATH /root/fennel-test/libfennel:$PATH
