#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo "You are root"
else
  echo "you are not root"
	exit 1
fi

score=0

#Forensics Question 1 correct - 8 pts
less /home/finn/Desktop/ForensicsQuestion1 | grep /home/jake
if [ $? -eq = 0 ]; then
	let "score += 8"
	echo "Forensics Question 1 correct - 8 pts"
else
	echo "you missed ForensicsQuestion1" >> /misseditems
fi

#Forensics Question 2 correct - 8 pts
less /home/finn/Desktop/ForensicsQuestion2 | grep candykingdom.earth
if [ $? -eq = 0 ]; then
	let "score += 8"
	echo "Forensics Question 2 correct - 8 pts"
else
	echo "you missed ForensicsQuestion2" >> /misseditems
fi

#Created user abracadaniel - 5 pts

#Removed unauthorized user gunter - 4 pts
tail /etc/shadow | grep gunter | grep "!"
if [ $? -eq = 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user gunter +4"
else
	echo "you missed locking out gunter from logging in" >> /misseditems
	tail /etc/shadow | grep gunter >> /misseditems
fi
https://www.youtube.com/watch?v=id5wEaxOVL0
#Removed unauthorized user hunsonadeer - 4 pts
tail /etc/shadow | grep hunsonadeer | grep "!"
if [ $? -eq = 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user hunsonadeer +4"
else
	echo "you missed locking out hunsonadeer from logging in" >> /misseditems
	tail /etc/shadow | grep hunsonadeer >> /misseditems
fi

#User lumpyspaceprincess is not an administrator - 4 pts
#User peppermintbutler is not an administrator - 4 pts
# group check section (needs fixing)
# lumpyspaceprincess=$(less /etc/group | grep "lumpyspaceprincess")
# lumpyspaceprincesssudo=$(grep sudo $lumpyspaceprincess)
# lumpyspaceprincessadm=$(grep adm $lumpyspaceprincess)
# if [ $lumpyspaceprincesssudo -eq 0 ]; then
# 	if [ $lumpyspaceprincessadm -eq 0 ]; then
# 		let "score += 4"
# 		echo "User lumpyspaceprincess is not an administrator"
# 	fi
# else
# 	echo "lumpyspaceprincess is an admin" >> /misseditems
# 	#tail /etc/shadow | grep miller >> /misseditems
# 	#passwd -l miller

#Changed insecure root password - 4 pts

#Guest account is disabled - 6 pts

#A default minimum password age is set - 6 pts

#Install updates from important security updates - 7 pts

#Linux kernel has been updated - 7 pts

#Sudo has been updated - 7 pts

#Prohibited MP3 files are removed - 6 pts

#DNS is disabled or removed - 6 pts

#Firewall has been enabled - 5 pts
ufw status | grep inactive
if [ $? -ne 0 ]; then
    let "score += 5"
		echo "Firewall enabled and set to start on default"
else
  echo "you missed ufw being off" >> /misseditems
  ufw status >> /misseditems
  ufw enable
fi

#SSH root login has been disabled - 7 pts


fi
echo "$score"
