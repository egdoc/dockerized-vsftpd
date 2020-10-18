#!/bin/bash
#
# Author: Egidio Docile <egdoc.dev@gmail.com>
#
set -o errexit
set -o nounset
set -o pipefail

# Create directories:
# /srv/ftp/${FTP_USER}  -> The home directory of the virtual user
# /etc/vsftpd           -> The directory that will host password file
# /var/run/vsftpd/empty -> Empty directory used to jail user when filesystem access is not needed
mkdir -p "/srv/ftp/${FTP_USER}/content" /etc/vsftpd /var/run/vsftpd/empty

# Chroot must not be writable for security reasons, so we create a subdir called
# content writable by the virtual user: it will hold all the files.
chown -R ftp:ftp "/srv/ftp/${FTP_USER}/content"

# Create chroot list file
touch /etc/vsftpd.chroot_list

# Create password file database
htpasswd -bcd "/etc/vsftpd/virtual_users.pwd" "${FTP_USER}" "${FTP_PASS}"

# Launch vsftpd
/usr/sbin/vsftpd