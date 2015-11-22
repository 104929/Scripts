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

#Forensics Question 2 correct - 5 pts

#UFW configured to drop or reject incoming connections by default - 2 pts

#UFW rule added to allow incoming SSH connections - 2 pts

#UFW rule added to allow incoming SMB connections - 2 pts

#Removed unauthorized user darbygambler - 2 pts

#Removed unauthorized user vanillaice - 2 pts

#Removed unauthorized user theworld - 2 pts

#Removed unauthorized user dio - 4 pts

#User holhorse is not an administrator - 2 pts

#User boingo is not an administrator - 2 pts

#Insecure root password changed - 1 pts

#Insecure password for user joseph - 1 pts

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
	mpv https://youtu.be/G65pvuTFR_A
	echo "Congratulations, you've overcome ZA WORLDO'!"
fi
