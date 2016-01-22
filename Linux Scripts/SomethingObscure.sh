#!/bin/bash
echo " Making the quarantine media files folder"
  if [ -d /quarantine/mediafiles ]; then
  	echo "/quarantine/mediafiles folder is already made"
  else
  	mkdir /quarantine/mediafiles
  fi
chmod u+rwx /files/mediafiles
for i in `cat /files/mediafiles`
do
mv "$i" /quarantine/mediafiles
echo "Media file $i has been moved!"
done
echo "done with media files"
nano /files/userlist.txt
for i in `more /files/userlist.txt`
do
echo $i
echo -e "Cyberpatriot!8\nCyberpatriot!8" | passwd "$i"
echo "User $i’s password was changed!"
done
