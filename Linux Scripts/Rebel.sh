#!/bin/bash
grep "permitrootlogin no" /etc/ssh/sshd_config -i >> /dev/null
if [ $? -eq 0 ]; then
  echo "Root login is correctly set"
fi
grep "sudo" /etc/gshadow
grep "adm:" /etc/gshadow

grep "PASS_MAX_DAYS" /etc/login.defs | grep 90
if [ $? -eq 0 ]; then
  echo "PASS_MAX_DAYS is correctly set"
else
  echo "PASS_MAX_DAYS needs to be set to 90 in /etc/login.defs" >> /files/log.log
fi
cat /etc/login.defs | grep "PASS_MIN_DAYS" | grep "10" >> /dev/null
if [ $? -eq 0 ]; then
  echo "PASS_MIN_DAYS is already correctly set"
else
  echo "PASS_MIN_DAYS is not correctly set in /etc/login.defs" >> /files/log.log
fi
ufw show listening
ufw status | grep -i active
if [ $? -ne 0 ]; then
  echo "Ufw is not enabled" >> /files/log.log
fi
if [ -e /etc/vsftpd.conf ]; then
  cat /etc/vsftpd.conf | grep -i "anonymous_enable" | grep NO >> /dev/null
  if [ $? -ne 0 ]; then
	echo "anonymous_enable needs to be set /etc/vsftpd.conf" >> /files/log.log
  fi
fi
ll /etc/sudoers.d | grep -v README >> /dev/null
if [ $? -eq 0 ]; then
  echo "There is something extra in /etc/sudoers.d" >> /files/log.log
fi
grep -i "NOPASSWD" /etc/sudoers >> /dev/null
if [ $? -eq 0 ]; then
	echo "Remember to visudo" >> /files/log.log
fi
grep LoginGraceTime /etc/ssh/sshd_config | grep 10 >> /dev/null
if [ $? -ne 0 ]; then
	echo "You need to secure login grace time in /etc/ssh/sshd_config" >> /files/log.log
fi
if [ $(cat /proc/sys/net/ipv6/conf/all/disable_ipv6) = 1 ]; then
	echo >> /dev/null
else
	echo "You need to disable IPv6" >> /files/log.log
fi
dpkg -l | grep bind9 -i | grep -vi Binding >> /files/log.log
cat /etc/mysql/my.cnf | grep "bind-address" | grep "#"
if [ $? -eq 0 ]; then
	echo "you need to bind mysql by uncommenting bind-address" >> /files/log.log
fi
