#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo "You are root, welcome to the scoring report!"
	echo " "
else
  echo "you are not root"
	exit 1
fi

score=0

#Hostname reset on the VM
hostname candykingdom

#resets the misseditems file
touch /misseditems
rm /misseditems

#Forensics Question 1 correct - 8 pts
less /home/finn/Desktop/ForensicsQuestion1 | grep /home/jake > /dev/null
if [ $? -eq 0 ]; then
	let "score += 8"
	echo "Forensics Question 1 correct - 8 pts"
else
	echo "you missed ForensicsQuestion1" >> /misseditems
fi

#Forensics Question 2 correct - 8 pts
less /home/finn/Desktop/ForensicsQuestion2 | grep candykingdom.earth > /dev/null
if [ $? -eq 0 ]; then
	let "score += 8"
	echo "Forensics Question 2 correct - 8 pts"
else
	echo "you missed ForensicsQuestion2" >> /misseditems
fi

#Created user abracadaniel - 5 pts
tail /etc/passwd | grep abracadaniel > /dev/null
if [ $? -eq 0 ]; then
	let "score += 5"
	echo "Created user abracadaniel - 5 pts"
else
	echo "you missed creating abracadaniel" >> /misseditems
fi

#Removed unauthorized user gunter - 4 pts
tail /etc/shadow | grep gunter | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user gunter - 4 pts"
else
	echo "you missed locking out gunter from logging in" >> /misseditems
fi

#Removed unauthorized user gunter - 4 pts
tail /etc/shadow | grep gunter > /dev/null
if [ $? -ne 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user gunter - 4 pts"
else
	echo "you missed locking out gunter from logging in (kind of)" >> /misseditems
fi

#Removed unauthorized user hunsonabadeer - 4 pts
tail /etc/shadow | grep hunsonabadeer | grep "!" > /devnull
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user hunsonabadeer - 4"
else
	echo "you missed locking out hunsonabadeer from logging in (kind of)" >> /misseditems
	tail /etc/shadow | grep hunsonabadeer >> /misseditems
fi

#Removed unauthorized user hunsonabadeer - 4 pts
tail /etc/shadow | grep hunsonabadeer > /dev/null
if [ $? -ne 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user hunsonabadeer - 4pts"
else
	echo "you missed locking out hunsonabadeer from logging in" >> /misseditems
	tail /etc/shadow | grep hunsonabadeer >> /misseditems
fi


#User lumpyspaceprincess is not an administrator - 4 pts
lspcounter=0
cat /etc/group | grep adm | grep lumpyspaceprincess > /dev/null
if [ $? -ne 0 ]; then
	let "lspcounter += 1"
fi

cat /etc/group | grep sudo | grep lumpyspaceprincess > /dev/null
if [ $? -ne 0 ]; then
	let "lspcounter += 1"
fi

if [ "$lspcounter" ==  2 ]; then
	let "score += 4"
	echo "User lumpyspaceprincess is not an administrator - 4 pts"
fi

#User peppermintbutler is not an administrator - 4 pts
pbcounter=0
cat /etc/group | grep adm | grep peppermintbutler > /dev/null
if [ $? -ne 0 ]; then
	let "pbcounter += 1"
fi

cat /etc/group | grep sudo | grep peppermintbutler > /dev/null
if [ $? -ne 0 ]; then
	let "pbcounter += 1"
fi

if [ "$pbcounter" ==  2 ]; then
	let "score += 4"
	echo "User peppermintbutler is not an administrator - 4 pts"
else
	echo "you missed peppermintbutler as an adm" >> /misseditems
fi

#Changed insecure root password - 4 pts
less /etc/shadow | grep root | grep "!" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Changed insecure root password - 4 pts"
else
	echo "you missed locking out root from logging in" >> /misseditems
fi

#Guest account is disabled - 6 pts
less /etc/lightdm/lightdm.conf | grep allow-guest | grep false > /dev/null
if [ $? -eq 0 ]; then
	let "score += 6"
	echo "Guest account is disabled - 6 pts"
else
	echo "you missed Guest account is disabled" >> /misseditems
fi

#A default minimum password age is set - 6 pts
less /etc/login.defs | grep PASS_MIN_DAYS | grep "0" > /dev/null
if [ $? -ne 0 ]; then
	let "score += 6"
	echo "A default minimum password age is set - 6 pts"
else
	echo "You missed a default minimum password age is set" >> /misseditems
fi

#Install updates from important security updates - 7 pts
less /etc/apt/sources.list | grep precise-security > /dev/null
if [ $? -eq 0 ]; then
	let "score += 7"
	echo "Install updates from important security updates - 7 pts"
else
	echo "you missed Install updates from important security updates - 7 pts" >> /misseditems
fi

#Linux kernel has been updated - 7 pts
uname -a | grep 3.13 > /dev/null
if [ $? -eq 0 ]; then
	let "score += 7"
	echo "Linux kernel has been updated - 7 pts"
else
	echo "you missed Linux kernel has been updated" >> /misseditems
fi

#Sudo has been updated - 7 pts
dpkg -l | grep sudo | grep 1.8.3 > /dev/null
if [ $? -eq 0 ]; then
	let "score += 7"
	echo "Sudo has been updated - 7 pts"
else
	echo "You missed a Sudo has been updated " >> /misseditems
fi

#Prohibited MP3 files are removed - 6 pts
ls /home/jake | grep .mp3 > /dev/null
if [ $? -ne 0 ]; then
    let "score += 6"
		echo "Prohibited MP3 files are removed - 6 pts"
else
	echo "You missed the MP3 files " >> /misseditems
fi

#DNS is disabled or removed - 6 pts
dpkg -l | grep bind9 | grep "Internet Domain Name" > /dev/null
if [ $? -ne 0 ]; then
    let "score += 6"
		echo "DNS is disabled or removed - 6 pts"
else
	echo "You missed the DNS service " >> /misseditems
fi

#Firewall has been enabled - 5 pts
ufw status | grep inactive > /dev/null
if [ $? -ne 0 ]; then
    let "score += 5"
		echo "Firewall has been enabled - 5 pts"
else
  echo "you missed ufw being off" >> /misseditems
  ufw status >> /misseditems
fi

#SSH root login has been disabled - 7 pts
cat /etc/ssh/sshd_config | grep PermitRootLogin | grep "no" > /dev/null
if [ $? -eq 0 ]; then
	let "score += 7"
	echo "SSH root login has been disabled - 7 pts"
else
	echo "you missed locking out root from logging in" >> /misseditems
fi

if [ "$score" -gt 100 ]; then
	let "score -= 4 "
fi
#End of score report
echo " "
echo -n "Your current total score is: "
echo -n "$score"
echo " pts"
if [ "$score" == 100 ]; then
	apt-get -qq install sl -y
	sl && sl && sl && sl && sl
	echo "Congratulations, you got a perfect score!"
fi
