#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo "You are root, welcome to the scoring report!"
	echo " "
else
  echo "you are not root"
	exit 1
fi

score=0

#Forensics Question 1 correct - 5 pts
less /home/jotaro/Desktop/ForensicsQuestion1 | grep theanswer > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "Forensics Question 1 correct - 5 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed ForensicsQuestion1" >> /misseditems
fi

#Forensics Question 2 correct - 5 pts
less /home/jotaro/Desktop/ForensicsQuestion2 | grep theanswer > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "Forensics Question 2 correct - 5 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed ForensicsQuestion2" >> /misseditems
fi

#UFW configured to drop or reject incoming connections by default - 2 pts
ufw status verbose | grep deny | grep incoming > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "UFW configured to drop or reject incoming connections by default - 2 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
  echo "you missed UFW configured to drop or reject incoming connections by default" >> /misseditems
  ufw status >> /misseditems
fi

#UFW rule added to allow incoming SSH connections - 2 pts
ufw status verbose | grep 22 | grep ALLOW > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "UFW rule added to allow incoming SSH connections - 2 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
  echo "you missed UFW rule added to allow incoming SSH connections - 2 pts" >> /misseditems
  ufw status >> /misseditems
fi

#UFW rule added to allow incoming SMB connections - 2 pts
ufw status verbose | grep Samba | grep ALLOW > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "UFW rule added to allow incoming SMB connections - 2 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
  echo "you missed UFW rule added to allow incoming SMB connections - 2 pts" >> /misseditems
  ufw status >> /misseditems
fi

#Removed unauthorized user darby - 2 pts
cat /etc/shadow | grep darby | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user darby - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out darby from logging in" >> /misseditems
fi

#Removed unauthorized user darby - 2 pts
cat /etc/shadow | grep darby > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user darby - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out darby from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user vanillaice - 2 pts
cat /etc/shadow | grep vanillaice | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user vanillaice - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out vanillaice from logging in" >> /misseditems
fi

#Removed unauthorized user vanillaice - 2 pts
cat /etc/shadow | grep vanillaice > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user vanillaice - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out vanillaice from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user theworld - 2 pts
cat /etc/shadow | grep theworld | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user theworld - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out theworld from logging in" >> /misseditems
fi

#Removed unauthorized user theworld - 2 pts
cat /etc/shadow | grep theworld > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user theworld - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out theworld from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user dio - 2 pts
cat /etc/shadow | grep dio | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user dio - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out dio from logging in" >> /misseditems
fi

#Removed unauthorized user dio - 2 pts
cat /etc/shadow | grep dio > /dev/null
if [ $? -ne 0 ]; then
	let "score += 2"
	echo "Removed unauthorized user dio - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
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
	echo "User holhorse is not an administrator - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
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
	let "score += 4"
	echo "User boingo is not an administrator - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed boingo as an adm" >> /misseditems
fi

#Insecure root password changed - 1 pts
less /etc/shadow | grep root | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Changed insecure root password - 4 pts"
	mpv --no-video --start=+12 --end=14 https://www.youtube.com/watch?v=thSElRaIBxc
else
	echo "you missed locking out root from logging in" >> /misseditems
fi

#Insecure password changed for user joseph - 1 pts

#Guest account is disabled - 4 pts

#An account lockout policy is configured - 5 pts

#A defualt maximum password age is set - 5 pts

#Install updates from important security updates - 3 pts

#Linux kernel has been updated - 2 pts

#Firefox has been updated - 2 pts

#Samba has been updated - 2 pts

#Bash has been updated - 2 pts

#Service MariaBD removed or disabled - 4 pts

#FTP service is removed or disabled - 4 pts

#Sudo requires authentification - 5 pts

#Prohibited MP3 files are removed - 3 pts

#Prohibited software kismet removed - 4 pts

#Prohibited software medusa removed - 4 pts

#Empty SSH Passwords are not permitted - 4 pts

#Samba root share removed - 5 pts

#End of score report
echo " "
echo -n "Your current total score is: "
echo -n "$score"
echo " pts"
if [ "$score" == 100 ]; then
	apt-get -qq install mpv -y
	mpv --no-video https://www.youtube.com/watch?v=-Tdu4uKSZ3M
	echo "Congratulations, you've overcome ZA WORLDO'!"
fi
