FROM debian:stable
LABEL maintainer="egdoc.dev@gmail.com"

ENV FTP_USER='user'
ENV FTP_PASS='password'

RUN apt-get update && apt-get install -y vsftpd apache2-utils libpam-pwdfile

COPY vsftpd.conf /etc/
COPY vsftpd_virtual /etc/pam.d/
COPY run.sh /sbin

VOLUME "/srv/ftp/${FTP_USER}"

EXPOSE 20 21

ENTRYPOINT ["/sbin/run.sh"]