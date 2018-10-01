FROM ruby:2.5.1-alpine
RUN apk add --no-cache bash unison openssh wget curl sudo
RUN sed -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
          -i /etc/sudoers
RUN cat /etc/sudoers
RUN addgroup -g 1000 -S developer && \
    adduser -u 1000 -S developer -G wheel -s /bin/bash

