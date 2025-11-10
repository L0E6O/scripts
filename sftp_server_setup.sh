#!/bin/sh
mkdir -p /data
chmod 701 /data
groupadd sftp_users
useradd -g sftp_users -d /upload -s /sbin/nologin remote_SFTP_user
passwd remote_SFTP_user
mkdir -p /data/remote_SFTP_user/upload
chown -R root:sftp_users /data/remote_SFTP_user
chown -R remote_SFTP_user:sftp_users /data/remote_SFTP_user/upload
echo "Match Group sftp_users
ChrootDirectory /data/%u
ForceCommand internal-sftp" >> /etc/ssh/sshd_config
systemctl restart sshd
dnf install ufw -y
systemctl enable sshd
ufw allow 22
ifconfig

