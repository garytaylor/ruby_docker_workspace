FROM alpine:3.8
RUN apk add --no-cache bash unison openssh wget curl gnupg tar alpine-sdk gcc curl ruby procps musl-dev make linux-headers zlib zlib-dev openssl openssl-dev libssl1.0
RUN sed -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
          -i /etc/sudoers
RUN cat /etc/sudoers
RUN addgroup -g 1000 -S developer && \
    adduser -u 1000 -S developer -G wheel -s /bin/bash

ADD docker-entrypoint.sh /usr/local/bin

#make sure we get fresh keys
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
RUN bash -c "echo -e \"developer\ndeveloper\" | passwd developer"
USER developer
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    \curl -sSL https://get.rvm.io | bash -s stable
EXPOSE 22
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD bash -c "sudo /usr/sbin/sshd -D"
