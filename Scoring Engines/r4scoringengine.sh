#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo "You are root, welcome to the scoring report!"
	echo " "
else
  echo "you are not root"
	exit 1
fi

score=0

apt-get install mpv -y -qq > /dev/null
apt-get install youtube-dl -y -qq > /dev/null
youtube-dl -q https://www.youtube.com/watch?v=o5lj1Pgjruo -o /donotdeltethisisforthescoringengnie.mp4 /dev/null

#Forensics Question 1 correct - 5 pts
less /home/jotaro/Desktop/ForensicsQuestion1 | grep hacked > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "Forensics Question 1 correct - 5 pts"
mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed ForensicsQuestion1" >> /misseditems
fi

#checking if Forensics Question 2 exists, if it doesn't, we create it
less /home/jotaro/Desktop/ForensicsQuestion2 | grep Coming -i >> /dev/null
if [ $? -eq 0 ]; then
	echo This is a Rot13 Encoded message. Decode the message. > /home/jotaro/Desktop/ForensicsQuestion2
	echo Encoded Message: GuvfVfGurCbvag >> /home/jotaro/Desktop/ForensicsQuestion2
	echo Decoded Message: >> /home/jotaro/Desktop/ForensicsQuestion2
fi

#Forensics Question 2 correct - 5 pts
less /home/jotaro/Desktop/ForensicsQuestion2 | grep ThisIsThePoint -i > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "Forensics Question 2 correct - 5 pts"
	mpv --really-quiet --no-video --start 2:38 --end 2:38.8 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed ForensicsQuestion2" >> /misseditems
fi

#Forensics Question 3 correct - 6 pts
less /home/jotaro/Desktop/ForensicsQuestion3 | grep Coming -i >> /dev/null
if [ $? -eq 0 ]; then
	echo There are several users that are allowed to access a Root samba share. List these users > /home/jotaro/Desktop/ForensicsQuestion3
	echo Users: >> /home/jotaro/Desktop/ForensicsQuestion3
fi
less /home/jotaro/Desktop/ForensicsQuestion3 | grep iggy -i > /dev/null
if [ $? -eq 0 ]; then
	let "score += 6"
	echo "Forensics Question 3 correct - 6 pts"
	mpv --really-quiet --no-video --start 2:38 --end 2:38.8 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed ForensicsQuestion3" >> /misseditems
fi

#UFW configured to drop or reject incoming connections by default - 2 pts
ufw status verbose | grep deny | grep incoming > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "UFW configured to drop or reject incoming connections by default - 2 pts"
	mpv --quiet --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc > /dev/null
else
  echo "you missed UFW configured to drop or reject incoming connections by default" >> /misseditems
  ufw status >> /misseditems
fi

#UFW rule added to allow incoming SSH connections - 2 pts
ufw status verbose | grep 22 | grep ALLOW > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "UFW rule added to allow incoming SSH connections - 2 pts"
	mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
  echo "you missed UFW rule added to allow incoming SSH connections - 2 pts" >> /misseditems
  ufw status >> /misseditems
fi

#UFW rule added to allow incoming SMB connections - 2 pts
ufw status verbose | grep Samba | grep ALLOW > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "UFW rule added to allow incoming SMB connections - 2 pts"
	mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
  echo "you missed UFW rule added to allow incoming SMB connections - 2 pts" >> /misseditems
  ufw status >> /misseditems
fi

#Removed unauthorized user darby - 2 pts
cat /etc/shadow | grep darby | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user darby - 4 pts"
	mpv --really-quiet --no-video https://www.youtube.com/watch?v=7zXzzSxlDoo > /dev/null
else
	echo "you missed locking out darby from logging in" >> /misseditems
fi

#Removed unauthorized user darby - 2 pts
cat /etc/shadow | grep darby > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user darby - 4 pts"
	mpv --really-quiet --no-video https://www.youtube.com/watch?v=7zXzzSxlDoo > /dev/null
else
	echo "you missed locking out darby from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user vanillaice - 2 pts
cat /etc/shadow | grep vanillaice | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user vanillaice - 4 pts"
	mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed locking out vanillaice from logging in" >> /misseditems
fi

#Removed unauthorized user vanillaice - 2 pts
cat /etc/shadow | grep vanillaice > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user vanillaice - 4 pts"
	mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed locking out vanillaice from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user petshop - 2 pts
cat /etc/shadow | grep petshop | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user petshop - 4 pts"
	mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed locking out petshop from logging in" >> /misseditems
fi

#Removed unauthorized user petshop - 2 pts
cat /etc/shadow | grep petshop > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user petshop - 4 pts"
	mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed locking out petshop from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user dio - 2 pts
cat /etc/shadow | grep dio | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user dio - 4 pts"
	mpv --really-quiet --no-video --start 0:04 https://www.youtube.com/watch?v=uFqjIOWs8Cg > /dev/null
else
	echo "you missed locking out dio from logging in" >> /misseditems
fi

#Removed unauthorized user dio - 2 pts
cat /etc/shadow | grep dio > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user dio - 4 pts"
	mpv --really-quiet --no-video --start 0:04 https://www.youtube.com/watch?v=uFqjIOWs8Cg > /dev/null
else
	echo "you missed locking out dio from logging in (kind of)" >> /misseditems
fi

#User holhorse is not an administrator - 2 pts
hhcounter=0
cat /etc/group | grep adm | grep holhorse > /dev/null
if [ $? -ne 0 ]; then
	let "hhcounter += 1"
fi

cat /etc/group | grep sudo | grep holhorse > /dev/null
if [ $? -ne 0 ]; then
	let "hhcounter += 1"
fi

if [ "$hhcounter" ==  2 ]; then
	let "score += 2"
	echo "User holhorse is not an administrator - 2 pts"
	mpv --really-quiet --no-video --start 0:04 https://www.youtube.com/watch?v=uFqjIOWs8Cg > /dev/null
fi

#User boingo is not an administrator - 2 pts
boingocounter=0
cat /etc/group | grep adm | grep boingo > /dev/null
if [ $? -ne 0 ]; then
	let "boingocounter += 1"
fi

cat /etc/group | grep sudo | grep boingo > /dev/null
if [ $? -ne 0 ]; then
	let "boingocounter += 1"
fi

if [ "$boingocounter" ==  2 ]; then
	let "score += 2"
	echo "User boingo is not an administrator - 2 pts"
	mpv --really-quiet --no-video --start 0:04 https://www.youtube.com/watch?v=uFqjIOWs8Cg > /dev/null
else
	echo "you missed boingo as an adm" >> /misseditems
fi

#Insecure root password changed - 1 pts
less /etc/shadow | grep root | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Changed insecure root password - 4 pts"
	mpv --really-quiet --no-video --start 0:04 https://www.youtube.com/watch?v=uFqjIOWs8Cg > /dev/null
else
	echo "you missed locking out root from logging in" >> /misseditems
fi

#Insecure password changed for user joseph - 1 pts
cat /etc/shadow | grep joseph | grep ! > /dev/null
if [ $? -eq 0 ]; then
	let "score += 1"
	echo "Insecure password changed for user joseph - 1 pts"
	mpv --really-quiet --no-video --start 0:04 https://www.youtube.com/watch?v=uFqjIOWs8Cg > /dev/null
else
	echo "you missed insecure password changed for user joseph - 1 pts" >> /misseditems
fi

#Guest account is disabled - 4 pts
cat /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf | grep guest | grep false > /dev/null
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Guest account is disabled - 4 pts"
	mpv --really-quiet --no-video --start 2:40 --end 2:42.5 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Guest account is disabled - 4 pts" >> /misseditems
fi

#An account lockout policy is configured - 5 pts
cat /etc/pam.d/common-auth | grep onerr | grep fail > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "An account lockout policy is configured - 5 pts"
	mpv --really-quiet --no-video --start 2:40 --end 2:41 /donotdeltethisisforthescoringengnie.mp4
else
	echo "An account lockout policy is configured - 5 pts" >> /misseditems
fi

#A defualt maximum password age is set - 5 pts
cat /etc/login.defs | grep PASS | grep MAX | grep 60 > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "A defualt maximum password age is set - 5 pts"
	mpv --really-quiet --no-video --start 2:40 --end 2:42 /donotdeltethisisforthescoringengnie.mp4
else
	echo "A defualt maximum password age is set - 5 pts" >> /misseditems
fi

#Install updates from important security updates - 3 pts
less /etc/apt/sources.list | grep precise-security > /dev/null
if [ $? -eq 0 ]; then
	let "score += 3"
	echo "Install updates from important security updates - 3 pts"
	mpv --really-quiet --no-video --start 2:40 --end 2:41 /donotdeltethisisforthescoringengnie.mp4
else
	echo "you missed Install updates from important security updates - 3 pts" >> /misseditems
fi

#Linux kernel has been updated - 2 pts
let "score += 2"
echo "Linux kernel has been updated - 2 pts"
mpv --really-quiet --no-video --start 2:38 --end 2:38.8 /donotdeltethisisforthescoringengnie.mp4

#Firefox has been updated - 2 pts
dpkg -l | grep firefox | grep "42" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Firefox has been updated - 2 pts"
	mpv --really-quiet --no-video --start 2:38 --end 2:38.8 /donotdeltethisisforthescoringengnie.mp4
else
	echo "You missed the firerfox update point" >> /misseditems
fi

#Samba has been updated - 2 pts
let "score += 2"
echo "Samba has been updated - 2 pts"
mpv --really-quiet --no-video --start 2:40 --end 2:41 /donotdeltethisisforthescoringengnie.mp4

#Bash has been updated - 2 pts
let "score += 2"
echo "Bash has been updated - 2 pts"
mpv --really-quiet --no-video --start 2:38 --end 2:38.8 /donotdeltethisisforthescoringengnie.mp4

#Service MariaDB removed or disabled - 4 pts
dpkg -l | grep mariadb  > /dev/null
if [ $? -ne 0 ]; then
	let "score += 4"
	echo "Service MariaDB removed or disabled - 4 pts"
	mpv --really-quiet --no-video --start 3:49 --end 3:51 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Service MariaDB removed or disabled - 4 pts" >> /misseditems
fi

#FTP service is removed or disabled - 4 pts
dpkg -l | grep vsftpd  > /dev/null
if [ $? -ne 0 ]; then
	let "score += 4"
	echo "FTP service is removed or disabled - 4 pts"
mpv --really-quiet --no-video --start 1:02 --end 1:03 /donotdeltethisisforthescoringengnie.mp4
else
	echo "FTP service is removed or disabled - 4 pts" >> /misseditems
fi

#Sudo requires authentification - 5 pts
ls /etc/sudoers.d/ | grep bowandarrow > /dev/null
if [ $? -ne 0 ]; then
	let "score += 5"
	echo "Sudo requires authentification - 5 pts"
	mpv --really-quiet --no-video --start 2:40 --end 2:43 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Sudo requires authentification - 5 pts" >> /misseditems
fi

#Prohibited MP3 files are removed - 3 pts
ls /home/joseph/cassetetapes/ | grep .mp3 > /dev/null
if [ $? -ne 0 ]; then
	let "score += 3"
	echo "Prohibited MP3 files are removed - 3 pts"
	mpv --quiet --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc > /dev/null
else
	echo "Prohibited MP3 files are removed - 3 pts" >> /misseditems
fi

#Prohibited software kismet removed - 4 pts
dpkg -l | grep kismet > /dev/null
if [ $? -ne 0 ]; then
	let "score += 4"
	echo "Prohibited software kismet removed - 4 pts"
	mpv --really-quiet --no-video --start 10:27 --end 10:29 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Prohibited software kismet removed - 4 pts" >> /misseditems
fi

#Prohibited software medusa removed - 4 pts
dpkg -l | grep medusa > /dev/null
if [ $? -ne 0 ]; then
	let "score += 4"
	echo "Prohibited software medusa removed - 4 pts"
	mpv --really-quiet --no-video --start 10:27 --end 10:29 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Prohibited software medusa removed - 4 pts" >> /misseditems
fi

#Empty SSH Passwords are not permitted - 4 pts
cat /etc/ssh/sshd_config | grep PermitEmptyPasswords | grep no > /dev/null
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Empty SSH Passwords are not permitted - 4 pts"
	mpv --really-quiet --no-video --start 10:27 --end 10:29 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Empty SSH Passwords are not permitted - 4 pts" >> /misseditems
fi

#Samba root share removed - 5 pts
cat /etc/samba/smb.conf | grep 'path = /' | grep '#' > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "Samba root share removed - 5 pts"
	mpv --really-quiet --no-video --start 11:46.7 --end 11:49 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Samba root share removed - 5 pts" >> /misseditems
fi

cat /etc/samba/smb.conf | grep "[Root]" > /dev/null
if [ $? -ne 0 ]; then
	let "score += 5"
	echo "Samba root share removed - 5 pts"
	mpv --really-quiet --no-video --start 11:46.7 --end 11:49 /donotdeltethisisforthescoringengnie.mp4
else
	echo "Samba root share removed - 5 pts" >> /misseditems
fi


#End of score report
echo
echo "Your current total score is: "
echo "$score"
echo -n " pts"
if [ "$score" == 100 ]; then
	apt-get -qq install mpv -y
	mpv --no-video https://www.youtube.com/watch?v=-Tdu4uKSZ3M > /dev/null
	echo "Congratulations, you've overcome ZA WORLDO'!"
fi
