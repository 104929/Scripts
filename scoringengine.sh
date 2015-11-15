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
else
  echo "you missed ufw being off" >> /misseditems
  ufw status >> /misseditems
  ufw enable
fi
ufw status verbose | grep Logging | grep -v high
if [ $? -ne 0 ]; then
  let "score += 5"
else
  echo "you missed setting ufw logging to high" >> /misseditems
  ufw status verbose | grep Logging >> /misseditems
  ufw logging high
fi
tail /etc/shadow | grep tommy | grep "!"
if [ $? -eq = 0 ]; then
	let "score += 5"
else
	echo "you missed locking out tommy from logging in" >> /misseditems
	tail /etc/shadow | grep tommy >> /misseditems
	passwd -l tommy
fi
tail /etc/shadow | grep miller | grep "!"
if [ $? -eq = 0 ]; then
	let "score += 5"
else
	echo "you missed locking out miller from logging in" >> /misseditems
	tail /etc/shadow | grep miller >> /misseditems
	passwd -l miller
fi
echo "$score"
