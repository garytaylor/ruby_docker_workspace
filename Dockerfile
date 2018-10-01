FROM ruby:2.5.1-slim-stretch
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y bash unison wget curl sudo git build-essential libpq-dev
RUN sed -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
          -i /etc/sudoers
RUN cat /etc/sudoers
#RUN addgroup -g 1000 -S developer && \
#    adduser -u 1000 -S developer -G wheel -s /bin/bash

