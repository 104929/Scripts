#!/bin/bash
echo "Make sure you are done with the Forensics Questions before running the script "
#Section 1.1 - Checks for root
if [ $(whoami) = "root" ]; then
  echo "You are root"
else
  echo "You are not root"
  exit 1
fi
#Section 1.2 - Checks for folders
if [ ! -d /files ]; then
  mkdir /files
fi
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
#Section 2.1 - Creates a text file called "mediafiles1" and gives it the neccasary permissions
touch /files/mediafiles1
chmod u+rwx /files/mediafiles1
#Section 2.2 - Finds any files within any home folders then sends their names to the mediafiles1 text file, each file on a new line
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
#Section 2.3 - Loops through each line in mediasfiles1, then moves each file to a quarantine folder
for i in `cat /files/mediafiles1`
do
mv "$i" /quarantine/mediafiles
echo "Media file $i has been moved!"
done
echo "Done with media files"
echo
#Section 3.1 - Opens a nano prompt where the user types in the names of every actual user on the system, seperated by a new line for every username
echo "Moving on to managing users"
nano /files/userlist.txt
#Section 3.2 - Loops through each line in userlist.txt , then for each username it changes the password to Cyberpatriot!8
for i in `more /files/userlist.txt`
do
echo $i
echo -e "Cyberpatriot!8\nCyberpatriot!8" | passwd "$i"
echo "User $i’s password was changed!"
done
echo "Done with managing users"
echo
#Section 4.1 - Asks the user if they are supposed to be an SSH server
echo "Moving on to securing SSH"
echo -n "Is this machine supposed to be an SSH server [y/n]"
read ssh
if [ $ssh == y ]; then
  echo "Fixing SSH files"
  apt-get install -y ssh openssh-client openssh-server
  if [ -a /etc/ssh/sshd_config ]; then
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    sed -i 's/Protocol 2,1/Protocol 2/g' /etc/ssh/sshd_config
    sed -i 's/Protocol 1,2/Protocol 2/g' /etc/ssh/sshd_config
    sed -i 's/PermitRootLogin without-password/PermitRootLogin no/g' /etc/ssh/sshd_config
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
  fi
  update-rc.d ssh defaults
  update-rc.d ssh enable
  ufw allow ssh
  ufw allow openssh
  ufw reload
  service ssh restart
  service ssh reload
  echo "Finished fixing SSH files"
fi
if [ $ssh == n ]; then
  echo "Removing and blocking SSH"
  apt-get purge -ymqq ssh openssh-client openssh-server
  service ssh stop
  update-rc.d -f ssh remove
  ufw deny ssh
  ufw deny openssh
  ufw reload
  echo "Finished removing and blocking SSH"
fi
echo "SSH security done"
#Section 4.2 - Asks the user if they are supposed to be an Apache server
echo "Moving on to securing Apache"
echo -n "Is this machine supposed to be an Apache server [y/n]"
read apache
if [ $apache == y ]; then
  echo "Fixing Apache files"
  apt-get install -ymqq --allow-unauthenticated apache2 libapache2-modsecurity
  chown -R root:root /etc/apache2
  chown -R root:root /etc/apache
  update-rc.d apache2 defaults
  update-rc.d apache2 enable
  #chmod u+rwx /var/www/html/
  #chmod g+rx /var/www/html/ && chmod g-w /var/www/html/
  #chmod o+rx /var/www/html/ && chmod o-w /var/www/html/
  sed -i 's/Timeout 300/Timeout 45/g' /etc/apache2/apache2.conf
  sed -i 's/KeepAlive On/KeepAlive Off/g' /etc/apache2/apache2.conf
  sed -i 's/MaxKeepAliveRequests 100/MaxKeepAliveRequests 50/g' /etc/apache2/apache2.conf
  sed -i 's/KeepAliveTimeout 5/KeepAliveTimeout 1/g' /etc/apache2/apache2.conf
  sed -i 's/ServerTokens OS/ServerTokens Prod/g' /etc/apache2/conf.d/security
  cat /etc/apache2/conf.d/security | grep TraceEnable On | grep "#" >> /dev/null
  if [ $? -ne 0 ]; then
  	echo "TraceEnable needs to be switched to off"
  fi
  cat /etc/apache2/apache2.conf | grep "LimitRequestBody 204800" >> /dev/null
  if [ $? -ne 0 ]; then
#      echo \<Directory \> >> /etc/apache2/apache2.conf
#      echo -e ' \t AllowOverride None' >> /etc/apache2/apache2.conf
#      echo -e ' \t Order Deny,Allow' >> /etc/apache2/apache2.conf
#      echo -e ' \t Deny from all' >> /etc/apache2/apache2.conf
#      echo -e ' \t Options None' >> /etc/apache2/apache2.conf
#      echo \<Directory \/\> >> /etc/apache2/apache2.conf
#	echo UserDir disabled root >> /etc/apache2/apache2.conf
    echo LimitRequestBody 204800 >> /etc/apache2/apache2.conf
  fi
  a2dismod autoindex
  a2dismod status
  sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/g' /etc/apache2/mods-enabled/security2.conf
  mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
  mv /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/
  service apache2 restart
  ufw allow apache
  ufw allow http
  ufw allow https
  ufw reload
  service apache2 restart
  ls -la etc/apache2/sites-enabled
  echo "Finished fixing Apache files"
fi
if [ $apache == n ]; then
  echo "Removing Apache"
  apt-get purge -ymqq --allow-unauthenticated apache2 libapache2-modsecurity
  service apache2 stop
  update-rc.d -f apache2 remove
  ufw deny apache
  ufw deny http
  ufw deny https
  ufw reload
  echo "Finished removing Apache"
fi
echo "Apache security done"
#Section 4.3 - Asks the user if they are supposed to be an Samba server
echo "Moving on to securing Samba"
echo -n "Is this machine supposed to be an Samba server [y/n]"
read samba
if [ $samba == y ]; then
  echo "Fixing Samba files"
  apt-get install -ymqq --allow-unauthenticated samba smbclient libsmbclient system-config-samba
  cat /etc/samba/smb.conf | grep usershare allow guests | grep yes
  if [ $?==0 ]; then
    sed -i 's/usershare allow guests yes/usershare allow guests no/g' /etc/ssh/sshd_config
    msg=$(echo usershare allow guests rule changed | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g' )
  fi
  update-rc.d samba defaults
  update-rc.d samba enable
  update-rc.d smbd defaults
  update-rc.d smbd enable
  update-rc.d nmbd defaults
  update-rc.d nmbd enable
  ufw allow samba
  ufw reload
  service samba restart
  service smbd restart
  service nmbd restart
  echo "Finished fixing Samba files"
fi
if [ $samba == n ]; then
  echo "Removing and blocking Samba"
  apt-get purge -ymqq --allow-unauthenticated samba smbclient libsmbclient
  service samba stop
  service smbd stop
  service nmbd stop
  update-rc.d -f samba remove
  update-rc.d -f smbd remove
  update-rc.d -f nmbd remove
  ufw deny samba
  ufw reload
  echo "Finished removing and blocking Samba"
fi
echo "Samba security done"
#Section 4.4 - Asks the user if they are supposed to be an FTP server
echo "Moving on to securing FTP"
echo -n "Is this machine supposed to be an FTP server [y/n]"
read ftp
if [ $ftp == y ]; then
  echo "Fixing FTP files"
  apt-get install -ymqq --allow-unauthenticated vsftpd
  if [ -e /etc/vsftpd.conf ]; then
    cat /etc/vsftpd.conf | grep anonymous_enable | grep yes
    if [ $?==0 ]; then
      sed -i 's/anonymous_enable yes/anonymous_enable no/g' /etc/ssh/sshd_config
      msg=$(echo anonymous_enable rule changed | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g' )
    fi
    cat /etc/vsftpd.conf | grep write_enable | grep yes
    if [ $?==0 ]; then
      sed -i 's/write_enable yes/write_enable no/g' /etc/ssh/sshd_config
      msg=$(echo write_enable rule changed | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g' )
    fi
    cat /etc/vsftpd.conf | grep anon_upload_enable | grep yes
    if [ $?==0 ]; then
      sed -i 's/anon_upload_enable yes/anon_upload_enable no/g' /etc/ssh/sshd_config
      msg=$(echo anon_upload_enable rule changed | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g' )
    fi
  fi
  ufw allow ftp
  ufw reload
  service vsftpd restart
  echo "Finished fixing FTP files"
fi
if [ $ftp == n ]; then
  echo "Removing and blocking FTP"
  apt-get purge -ymqq --allow-unauthenticated vsftpd
  service vsftpd stop
  ufw deny ftp
  ufw reload
  echo "Finished removing and blocking FTP"
fi
echo "FTP security done"
#Section 4.5 - Asks the user if they are supposed to be an MySQL server
echo "Moving on to securing MySQL"
echo -n "Is this machine supposed to be an MySQL server (Type nothing if you have or need a third party MySQL server program ex. MariaDB) [y/n]"
read mysql
if [ $mysql == y ]; then
  echo "Fixing FTP files"
  apt-get install -ymqq --allow-unauthenticated mysql-client mysql-server
  update-rc.d mysql defaults
  update-rc.d mysql enable
  ufw allow mysql
  ufw reload
  service mysql restart
  echo "Finished fixing MySQL files"
fi
if [ $mysql == n ]; then
  echo "Removing and blocking MySQL"
  apt-get purge -ymqq --allow-unauthenticated mysql-client mysql-server mariadb-client mariadb-server
  service mysql stop
  update-rc.d -f mysql remove
  ufw deny mysql
  ufw reload
  echo "Finished removing and blocking MySQL"
fi
echo "MySQL security done"
#Section 4.6 - Asks the user if they are supposed to be an DNS server
echo "Moving on to securing DNS"
echo -n "Is this machine supposed to be an DNS server [y/n]"
read dns
if [ $dns == y ]; then
  echo "Fixing FTP files"
  apt-get install -ymqq --allow-unauthenticated dnsutils bind9
  update-rc.d bind9 defaults
  update-rc.d bind9 enable
  ufw allow bind9
  ufw reload
  service bind9 restart
  echo "Finished fixing DNS files"
fi
if [ $dns == n ]; then
  echo "Removing and blocking DNS"
  apt-get purge -ymqq --allow-unauthenticated bind9
  service bind9 stop
  update-rc.d -f bind9 remove
  ufw deny bind9
  ufw reload
  echo "Finished removing and blocking DNS"
fi
echo "DNS security done"
#Section 5.1 - Sets up Auditing
echo "Doing Auditing Now"
auditctl -e 1 > /dev/null
sed -i 's/num_logs = 5/num_logs = 4/g' /etc/audit/auditd.conf
sed -i 's/max_log_file = 6/max_log_file = 5/g' /etc/audit/auditd.conf
echo "auditing done"
echo
#Section 5.2 - Sets up Login.defs
echo "Securing Login.defs now"
sed -i 's/LOG_OK_LOGINS           no/LOG_OK_LOGINS           yes/g' /etc/login.defs
sed -i 's/PASS_MIN_DAYS   0/PASS_MIN_DAYS   10/g' /etc/login.defs
sed -i 's/PASS_MAX_DAYS   9999/PASS_MAX_DAYS 90/g' /etc/login.defs
sed -i 's/LOGIN_RETRIES           5/LOGIN_RETRIES           3/g' /etc/login.defs
sed -i 's/PASS_WARN_AGE   0/PASS_WARN_AGE   7/g' /etc/login.defs
echo "Login.defs is now secure"
echo
#Section 5.3 - Sets up Pam
echo "Securing Pam.d now"
grep "auth 	required 			pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent" /etc/pam.d/common-auth >> /dev/null
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
#Section 5.4 - Removes any users from sudoers file that do not require a password
#echo "Editing Sudoers file now"
#grep NOPASSWD /etc/sudoers
#if [ $?==0 ]; then
#  sudo1=$(grep NOPASSWD /etc/sudoers)
#  sed -i 's/$sudo1/ /g' /etc/sudoers
#  msg=$(echo SUDOERS NOPASSWD rule removed | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g')
#fi
#echo "Sudoers file is done"
echo
#Section 5.5 - Sets up LightDM
echo "Moving on to securing LightDM"
echo -n "Is this machine running Ubuntu 12.04 or 14.04 [12/14]"
read lightdm
if [ $lightdm == 12 ]; then
  echo "Fixing LightDM files for Ubuntu 12.04"
  /usr/lib/lightdm/lightdm-set-defaults -l false
  if [ $?==0 ]; then
    msg=$(echo Set allow guest to false | sed 's/\//%2F/g' | sed 's/\./%2E/g' | sed 's/\ /%20/g' )
  fi
  echo "exit 0" > /etc/rc.local
  msg=$(echo X11Forwarding rule changed to exclusively 1 | sed 's/\//%2F/g' | sed 's/\./%2E/g' )
  grep "[SeatDefaults]" /etc/lightdm/lightdm.conf
  if [ "$?" -eq "1" ]; then
    echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf
  fi  
  grep "greeter-hide-users=true" /etc/lightdm/lightdm.conf
  if [ "$?" -eq "1" ]; then
    echo "greeter-hide-users=true" >> /etc/lightdm/lightdm.conf
  fi
  grep "greeter-show-manual-login=true" /etc/lightdm/lightdm.conf
  if [ "$?" -eq "1" ]; then
    echo "greeter-show-manual-login=true" >> /etc/lightdm/lightdm.conf
  fi
  echo "Finished fixing LightDM files for Ubuntu 12.04"
fi
if [ $lightdm == 14 ]; then
  echo "Fixing LightDM files for Ubuntu 14.04"
  if [ ! -d /etc/lightdm/lightdm.conf.d ]; then
    mkdir -p /etc/lightdm/lightdm.conf.d
  fi
  if [ -d /etc/lightdm/lightdm.conf.d ]; then
    if [ ! -f /etc/lightdm/lightdm.conf.d/50-guest-session.conf ]; then
    echo "[SeatDefaults]" > /etc/lightdm/lightdm.conf.d/50-guest-session.conf
    echo "allow-guest=false" >> /etc/lightdm/lightdm.conf.d/50-guest-session.conf
    echo "[SeatDefaults]" > /etc/lightdm/lightdm.conf.d/50-show-users.conf
    echo "greeter-hide-users=true" >> /etc/lightdm/lightdm.conf.d/50-show-users.conf
    echo "[SeatDefaults]" > /etc/lightdm/lightdm.conf.d/50-manual-login.conf
    echo "greeter-show-manual-login=true" >> /etc/lightdm/lightdm.conf.d/50-manual-login.conf
    fi
  fi
  echo "Finished fixing LightDM files for Ubuntu 14.04"
fi
echo "Remember to restart LightDM (or the system) when the script is done"
echo "LightDM security done"
#Section 6.1 - Removes any common hacking tools
echo "Uninstalling packages now"
apt-get purge --auto-remove john hydra aircrack kismet medusa nmap vlc fingerd finger netcat dhcpdump snort p0f aircrack-ng nc hydra-gtk bind9 wireshark
echo
#Section 6.2 - Sets up file permissions
echo "Changing file permissions now"
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
chmod 400 /etc/cron.allow
chmod 400 /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow

#echo "Looking for all the files on the system with 777 permissions"
#find / -type d -perm +2 -ls -exec grep -vi "dev|tmp" {} +

#Section 7.1 - Sets up basic ufw rules
echo "Doing Ufw now"
ufw default deny incoming
ufw reload
echo "Done with ufw"
echo
#Section 7.2 - Clears hosts file
echo "Clearing host file now"
echo 127.0.0.1	localhost > /etc/hosts
echo 127.0.1.1	$(hostname)  >> /etc/hosts
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
