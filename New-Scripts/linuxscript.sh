#!/bin/bash
if [ $(whoami) = "root" ]; then
  echo "You are root"
else
  echo "You are not root"
  exit 1
fi
#Section 1.2 - Checks for folders
if [ ! -d /files ]; then
  mkdir /files
fi
echo " Making the quarantine media files folder"
if [ -d /quarantine/ ]; then
  echo "/quarantine/ folder is already made"
else
  mkdir /quarantine/
fi
if [ -d /quarantine/mediafiles ]; then
  echo "/quarantine/mediafiles folder is already made"
else
  mkdir /quarantine/mediafiles
fi
#Section 2.1 - Creates a text file called "mediafiles1" and gives it the neccasary permissions
touch /files/mediafiles1
chmod u+rwx /files/mediafiles1
#Section 2.2 - Finds any files within any home folders then sends their names to the mediafiles1 text file, each file on a new line
find /home -iname "*.mp3" -print  > /files/mediafiles1
find /home -iname "*.mp4" -print  >> /files/mediafiles1
find /home -iname "*.pot" -print  >> /files/mediafiles1
find /home -iname "*.rhost" -print  >> /files/mediafiles1
find /home -iname "*.wav" -print  >> /files/mediafiles1
find /home -iname "*.wmv" -print  >> /files/mediafiles1
find /home -iname "*.wma" -print  >> /files/mediafiles1
find /home -iname "*.flv" -print  >> /files/mediafiles1
find /home -iname "*.mov" -print  >> /files/mediafiles1
find /home -iname "*.avi" -print  >> /files/mediafiles1
find /home -iname "*.mpeg" -print  >> /files/mediafiles1
find /home -iname "*.mpg" -print  >> /files/mediafiles1
find /home -iname "*.jpeg" -print  >> /files/mediafiles1
find /home -iname "*.jpg" -print  >> /files/mediafiles1
find /home -iname "*.png" -print  >> /files/mediafiles1
find /home -iname "*.psd" -print  >> /files/mediafiles1
find /home -iname "*.bmp" -print  >> /files/mediafiles1
find /home -iname "*.gif" -print  >> /files/mediafiles1
find /home -iname "*.tif" -print  >> /files/mediafiles1
find /home -iname "*.tiff" -print  >> /files/mediafiles1
find /home -iname "*.rec" -print  >> /files/mediafiles1
find /home -iname "*.mkv" -print >> /files/mediafiles1
apt-get install ufw sudo -ymqq
ufw reset
ufw default deny outgoing
ufw default deny incoming
ufw logging low
ufw allow out http
ufw allow out https
ufw allow out domain
ufw allow out 53
ufw allow out 8089
ufw allow out 9997
adduser safety
adduser safety adm
adduser safety sudo
