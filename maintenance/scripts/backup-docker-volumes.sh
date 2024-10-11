#!/usr/bin/zsh

# app info is in google console; see notion for configuration info
rclone --progress sync /var/lib/docker/volumes gdrive:/beelink-docker-volumes -vv
