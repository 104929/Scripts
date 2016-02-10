#!/bin/bash
grep "permitrootlogin no" /etc/ssh/sshd_config -i
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
grep -i "NOPASSWD" /etc/sudoers
if [ $? -eq 0 ]; then
  echo "Remember to visudo" >> /files/log.log
fi
