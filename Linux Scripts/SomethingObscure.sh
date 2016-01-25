#!/bin/bash
echo " Making the quarantine media files folder"
  if [ -d /quarantine/ ]; then
  	echo "/quarantine/ folder is already made"
  else
  	mkdir /quarantine/
  fi
  if [ -d /quarantine/mediafiles ]; then
  	echo "/quarantine/mediafiles folder is already made"
  else
  	mkdir /quarantine/mediafiles
  fi
echo " Making the files folder"
  if [ -d /files/ ]; then
  	echo "/files/ folder is already made"
  else
  	mkdir /files
  fi
touch /files/mediafiles1
chmod u+rwx /files/mediafiles1
find /home -iname "*.mp3" -print  > /files/mediafiles1
find /home -iname "*.mp4" -print  >> /files/mediafiles1
find /home -iname "*.pot" -print  >> /files/mediafiles1
find /home -iname "*.rhost" -print  >> /files/mediafiles1
find /home -iname "*.wav" -print  >> /files/mediafiles1
find /home -iname "*.wmv" -print  >> /files/mediafiles1
find /home -iname "*.wma" -print  >> /files/mediafiles1
find /home -iname "*.flv" -print  >> /files/mediafiles1
find /home -iname "*.mov" -print  >> /files/mediafiles1
find /home -iname "*.avi" -print  >> /files/mediafiles1
find /home -iname "*.mpeg" -print  >> /files/mediafiles1
find /home -iname "*.mpg" -print  >> /files/mediafiles1
find /home -iname "*.jpeg" -print  >> /files/mediafiles1
find /home -iname "*.jpg" -print  >> /files/mediafiles1
find /home -iname "*.png" -print  >> /files/mediafiles1
find /home -iname "*.psd" -print  >> /files/mediafiles1
find /home -iname "*.bmp" -print  >> /files/mediafiles1
find /home -iname "*.gif" -print  >> /files/mediafiles1
find /home -iname "*.tif" -print  >> /files/mediafiles1
find /home -iname "*.tiff" -print  >> /files/mediafiles1
find /home -iname "*.rec" -print  >> /files/mediafiles1
find /home -iname "*.mkv" -print >> /files/mediafiles1
for i in `cat /files/mediafiles1`
do
mv "$i" /quarantine/mediafiles
echo "Media file $i has been moved!"
done
echo "Done with media files"
echo
echo "Moving on to managing users"
nano /files/userlist.txt
for i in `more /files/userlist.txt`
do
echo $i
echo -e "Cyberpatriot!8\nCyberpatriot!8" | passwd "$i"
echo "User $i’s password was changed!"
done
echo "Done with managing users"
echo
echo "Moving on to securing apache"
if [ -e /etc/apache2/apache2.conf ]; then
  cat /etc/apache2/apache2.conf | grep "LimitRequestBody 204800" >> /dev/null
  if [ $? -ne 0 ]; then
    echo \<Directory \> >> /etc/apache2/apache2.conf
    echo -e ' \t AllowOverride None' >> /etc/apache2/apache2.conf
    echo -e ' \t Order Deny,Allow' >> /etc/apache2/apache2.conf
    echo -e ' \t Deny from all' >> /etc/apache2/apache2.conf
    echo \<Directory \/\> >> /etc/apache2/apache2.conf
    echo UserDir disabled root >> /etc/apache2/apache2.conf
    echo ServerTokens Prod >> /etc/apache2/apache2.conf
    echo ServerSignature Off >> /etc/apache2/apache2.conf
    echo LimitRequestBody 204800 >> /etc/apache2/apache2.conf
  fi
  a2dismod autoindex
  a2dismod status
  sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/g' /etc/apache2/mods-enabled/security2.conf
  mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
  mv /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/
  service apache2 restart
  echo "Apache security done"
fi
echo
echo "Moving on to SSH Configuration"
if [ -a /etc/ssh/sshd_config ]; then
  sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  sed -i 's/Protocol 2,1/Protocol 2/g' /etc/ssh/sshd_config
  sed -i 's/Protocol 1,2/Protocol 2/g' /etc/ssh/sshd_config
  sed -i 's/PermitRootLogin without-password/PermitRootLogin no/g' /etc/ssh/ssh
  sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_configd_config
  sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config
  sed -i 's/UsePam no/UsePam yes/g' /etc/ssh/sshd_config
  sed -i 's/RSAAuthentication no/RSAAuthentication yes/g' /etc/ssh/sshd_config
  sed -i 's/PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
  sed -i 's/LoginGraceTime 120/LoginGraceTime 60/g' /etc/ssh/sshd_config
  sed -i 's/StrictModes no/StrictModes yes/g' /etc/ssh/sshd_config
  sed -i 's/IgnoreRhosts no/IgnoreRhosts yes/g' /etc/ssh/sshd_config
  sed -i 's/TCPKeepAlive yes/TCPKeepAlive no/g' /etc/ssh/sshd_config
  sed -i 's/UsePrivilegeSeperation no/UsePrivilegeSeperation yes/g' /etc/ssh/sshd_config
  sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
  sed -i 's/PermitBlacklistedKeys yes/PermitBlacklistedKeys no/g' /etc/ssh/sshd_config
  sed -i 's/HostbasedAuthentication yes/HostbasedAuthentication no/g' /etc/ssh/sshd_config
  sed -i 's/PrintMotd yes/PrintMotd no/g' /etc/ssh/sshd_config
  echo "ssh config done"
fi
echo "Doing Auditing Now"
auditctl -e 1 > /dev/null
sed -i 's/num_logs = 5/num_logs = 4/g' /etc/audit/auditd.conf
sed -i 's/max_log_file = 6/max_log_file = 5/g' /etc/audit/auditd.conf
echo "auditing done"
echo
echo "Securing Login.defs now"
sed -i 's/LOG_OK_LOGINS           no/LOG_OK_LOGINS           yes/g' /etc/login.defs
sed -i 's/PASS_MIN_DAYS   0/PASS_MIN_DAYS   10/g' /etc/login.defs
sed -i 's/PASS_MAX_DAYS   9999/PASS_MAX_DAYS 90/g' /etc/login.defs
sed -i 's/LOGIN_RETRIES           5/LOGIN_RETRIES           3/g' /etc/login.defs
sed -i 's/PASS_WARN_AGE   0/PASS_WARN_AGE   7/g' /etc/login.defs
echo "Login.defs is now secure"
echo
echo "Securing Pam.d now"
grep "auth 	required 			pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent" /etc/pam.d/common-auth
if [ "$?" -eq "1" ]; then
  echo "auth 	required 			pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent" >> /etc/pam.d/common-auth
	echo "password 	requisite 			pam_cracklib.so retry=3 minlen=8 difok=3 reject_username minclass=3 maxrepeat=2 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1" >> /etc/pam.d/common-password
	echo "password 	[success=1 default=ignore] 	pam_unix.so obscure use_authtok try_first_pass sha512 minlen=8 remember=5" >> /etc/pam.d/common-password
	echo "password 	requisite 			pam_pwhistory.so use_authtok remember=5 enforce_for_root" >>  /etc/pam.d/common-password
fi
echo
echo "Editing Sysctl.conf now"
sed -i 's/net.ipv4.ip_forward=1/net.ipv4.ip_forward=0/g' /etc/sysctl.conf
sed -i 's/net.ipv4.tcp_syncookies=1/net.ipv4.tcp_syncookies=1/g' /etc/sysctl.conf
sysctl -w net.ipv4.tcp_syncookies=1
sysctl -w net.ipv4.ip_forward=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0
echo
echo "Editing Sudoers file now"
grep NOPASSWD /etc/sudoers
if [ $?==0 ]; then
               sudo1=$(grep NOPASSWD /etc/sudoers)
		sed -i 's/$sudo1/ /g' /etc/sudoers
     	        msg=$(echo SUDOERS NOPASSWD rule removed | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g'  )
     	        
fi
echo "Sudoers file is done"
echo
echo "Uninstalling packages now"
apt-get purge --auto-remove john hydra aircrack kismet medusa nmap fingerd finger netcat dhcpdump snort p0f aircrack-ng nc hydra-gtk bind9 wireshark
echo
echo "Changing file permissions now"
chmod 0700 /etc/rc*
chmod 0700 /etc/init.d*
chmod 0700 /etc/profile
chmod 0700 /etc/hosts.allow
chmod 0700 /etc/mtab
chmod 0700 /etc/utmp
chmod 0700 /var/adm/wtmp
chmod 0700 /var/log/wtmp
chmod 0700 /etc/syslog.pid
chmod 0700 /var/run/syslog.pid
chmod 0700 /etc/sysctl.conf
chmod 0700 /etc/inittab
chmod 644 /etc/fstab
chmod 644 /etc/passwd
chmod 400 /etc/shadow
chmod 644 /etc/group
chmod 644 /etc/sudoers

chmod 02750 /bin/su
chmod 02750 /bin/sudo
chmod 02750 /bin/ping
chmod 02750 /sbin/ifconfig
chmod 02750 /usr/bin/w
chmod 02750 /usr/bin/who
chmod 02750 /usr/bin/locate
chmod 02750 /usr/bin/whereis

rm -f /etc/cron.deny
rm -f /etc/at.deny
echo root > /etc/cron.allow
echo root > /etc/at.allow
chmod 400 cron.allow
chmod 400 at.allow
chown root:root cron.allow
chown root:root at.allow

#echo "Looking for all the files on the system with 777 permissions"
#find / -type d -perm +2 -ls -exec grep -vi "dev|tmp" {} +

echo "Doing Ufw now"
ufw default deny incoming
ufw reload
echo "Done with ufw"
echo
echo "Clearing host file now"
echo 127.0.0.1	localhost > /etc/hosts
echo 127.0.1.1	$(hostname -f)  >> /etc/hosts
echo ::1     ip6-localhost ip6-loopback >> /etc/hosts
echo fe00::0 ip6-localnet >> /etc/hosts
echo ff00::0 ip6-mcastprefix >> /etc/hosts
echo ff02::1 ip6-allnodes >> /etc/hosts
echo ff02::2 ip6-allrouters >> /etc/hosts
echo
echo "The host file is cleared"


apt-get autoremove
apt-get autoclean

echo "You are done and should probably reboot"
