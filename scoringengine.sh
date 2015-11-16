#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo "You are root"
else
  echo "you are not root"
	exit 1
fi
score=0
ufw status | grep inactive
if [ $? -ne 0 ]; then
    let "score += 5"
		echo "Firewall enabled and set to start on default"
else
  echo "you missed ufw being off" >> /misseditems
  ufw status >> /misseditems
  ufw enable
fi
tail /etc/shadow | grep gunter | grep "!"
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user gunter +4"
else
	echo "you missed locking out gunter from logging in" >> /misseditems
	tail /etc/shadow | grep gunter >> /misseditems
fi
tail /etc/shadow | grep hunsonadeer | grep "!"
if [ $? -eq 0 ]; then
	let "score += 4"
	echo "Removed unauthorized user hunsonadeer +4"
else
	echo "you missed locking out hunsonadeer from logging in" >> /misseditems
	tail /etc/shadow | grep hunsonadeer >> /misseditems
fi
lumpyspaceprincess=$(less /etc/group | grep "lumpyspaceprincess")
lumpyspaceprincesssudo=$(grep sudo $lumpyspaceprincess)
lumpyspaceprincessadm=$(grep adm $lumpyspaceprincess)
if [ $lumpyspaceprincesssudo -eq 0 ]; then
	if [ $lumpyspaceprincessadm -eq 0 ]; then
		let "score += 4"
		echo "User lumpyspaceprincess is not an administrator"
	fi
else
	echo "lumpyspaceprincess is an admin" >> /misseditems
	#tail /etc/shadow | grep miller >> /misseditems
	#passwd -l miller
fi
echo "$score"
