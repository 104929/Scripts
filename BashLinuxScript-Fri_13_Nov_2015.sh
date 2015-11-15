#!/bin/bash
# (https://kobra.io/#/e/-K2iux1STBxTmNRL1snf)
#Fri 13 Nov 2015 05:10:38 AM UTC
echo "Make sure this script is copied somewhere else on the computer and unplug your flashdrive before running the script"
alias | grep john -i
if [ $? -eq 0 ]; then
  echo "john is an alias. stop script and find out why"
fi
alias | grep hydra
if [ $? -eq 0 ]; then
  echo "There is a password cracker as an alias, stop script and find out why"
fi
if [ $(which apt-get) == "/usr/bin/apt-get" ]; then
    echo "apt-get is good"
else
	echo "apt-get is bad"
	alias apt-get='/usr/bin/apt-get'
fi
echo
if [ $(which ufw) == "/usr/sbin/ufw" ]; then
	echo "ufw is good"
else
	echo "ufw is bad"
	alias ufw='/usr/sbin/ufw'
fi
#echo
#if [ $(which nano) == "/usr/bin/nano" ]; then
#	echo "nano is good"
#else
#	echo "nano is bad"
#	alias nano='/usr/bin/nano'
#Nano is taken out of script because it is a specific text editior that cyberpatriot would have to specifically target and expect us to use it
#But mainly because it changes places based off of the ubuntu version
#fi
echo
if [ $(which ls) == "/bin/ls" ]; then
	echo "ls is good"
else
	echo "ls is bad"
	alias ls='/bin/ls'
fi
echo
if [ $(which grep) == "/bin/grep" ]; then
	echo "grep is good"
else
	echo "grep is bad"
	alias grep='/bin/grep'
fi
echo "       "
if [ $(which sudo) == "/usr/bin/sudo" ]; then
	echo "sudo is good"
else
	echo "sudo is bad"
	alias sudo='/usr/bin/sudo'
fi
echo "		"
if [ $(which cp) == "/bin/cp" ]; then
	echo "cp is good"
else
	echo "cp is bad"
	alias cp='/bin/cp'
fi
echo
if [ $(which mv) == "/bin/mv" ]; then
	echo "mv is good"
else
	echo "mv is bad"
	alias mv='/bin/mv'
fi
echo
echo "Commands are good. Moving on to check if you are root"
echo
if [ $(whoami) = "root" ]; then
	echo "You are root"
else
	exit 1
fi
echo " managing ufw now"
ufw enable
ufw logging high
ufw reload
echo " Moving on to making the quarantine folder"
if [ -d /quarantine ]; then
	echo "/quarantine folder is already made"
else
	mkdir /quarantine
fi
echo "Doing Recon now"
echo
if [ -d /files/ ]; then
	echo "/files/ already exist"
else
	mkdir /files/
fi
touch /files/mediafiles
find / -iname "*.mp3" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  > /files/mediafiles
find / -iname "*.mp4" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.pot" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.rhost" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.wav" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.wmv" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.mov" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.avi" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.mpeg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.jpeg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.jpg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.png" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.gif" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.tif" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.tiff" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.rec" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
find / -iname "*.mkv" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/mediafiles
touch /files/malware
echo "Remember the alias of uninstall to remove any of these packages"
dpkg -l | grep john -i > /files/malware #Looks for. john installed
ps aux | grep john -i | grep -v grep >> /files/malware #looks for john running
lsof | grep /etc/passwd >> /files/malware
lsof | grep shadow >> /files/malware
find /etc/cron* -iname "john" -print
find / -iname "*.pot" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/malware
find / -iname "*.rec" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/malware
find / -iname "john" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/malware
echo "searched for john, now searching for hydra"
echo "searched for john, now searching for hydra" >> /files/malware
echo "	" >> /files/malware #puts space in malware
dpkg -l | grep hydra -i >> /files/malware #looks for hydra installed
ps aux | grep hydra -i | grep -v grep >> /files/malware #looks for hydra running
find / -iname "hydra" -print >> /files/malware
echo "searched for hydra, now searching for netcat" >> /files/malware
echo "searched for hydra, now searching for netcat"
echo "	" >> /files/malware #Puts space in malware
#dpkg -l | grep nc -i >> /files/malware #looks for nc installed
dpkg -l | grep cryptcat -i >> /files/malware
dpkg -l | grep netcat -i | grep -v openbsd >> /files/malware #looks for netcat installed
dpkg -l | grep ncat -i >> /files/malware
ps aux | grep netcat -i | grep -v grep >> /files/malware #looks for netcat running
ps aux | grep cryptcat -i | grep -v grep >> /files/malware
#netstat -anp | grep nc -i >> /files/malware
netstat -anp | grep ncat -i >> /files/malware
netstat -anp | grep netcat -i >> /files/malware
netstat -anp | grep cryptcat -i >> /files/malware
find / -iname "netcat" -print >> /files/malware
find / -iname "cryptcat" -print >> /files/malware
find / -iname "ncat" -print >> /files/malware
echo "searched for netcat, now searching for cain & abel"
echo "searched for netcat, now searching for cain & abel" >> /files/malware
#ps aux | grep nc -i | grep -v grep >> /files/malware #looks for nc running
echo "	" >> /files/malware  #Puts space in malware
dpkg -l | grep cain -i >> /files/malware #looks for cain installed
find / -iname "cain" -print >> /files/malware
#dpkg -l | grep abel -i >> /files/malware #looks for abel installed
#find / -iname "abel" -print >> /files/malware
ps aux | grep cain -i | grep -v grep >> /files/malware #look for cain running
#ps aux | grep abel -i | grep -v grep >> /files/malware #looks for abel running
echo "searched for cain & abel, now searching for medusa"
echo "searched for cain & abel, now searching for medusa" >> /files/malware
echo "	" >> /files/malware  #Puts space in malware
dpkg -l | grep medusa -i >> /files/malware #Looks for medusa installed
find / -iname "medusa" -print >> /files/malware
ps aux | grep medusa -i | grep -v grep >> /files/malware #Looks for medusa running
echo "	" >> /files/malware  #Puts space in malware
echo "searched for medusa, now searching for aircrack"
echo "searched for medusa, now searching for aircrack" >> /files/malware
dpkg -l | grep aircrack -i >> /files/malware #Looks for aircrack installed
find / -iname "aircrack" -print >> /files/malware
ps aux | grep aircrack -i | grep -v grep >> /files/malware  #looks for aircrack running
echo "	" >> /files/malware	  #Puts space in malware
echo "searched for aircrack, now searching for nmap"
echo "searched for aircrack, now searching for nmap" >> /files/malware
dpkg -l | grep nmap -i >> /files/malware #looks for nmap installed
find / -iname "nmap" -print >> /files/malware
ps aux | grep nmap -i | grep -v grep >> /files/malware  #looks for nmap running
echo "	" >> /files/malware  #Puts space in malware
echo "searched for nmap, now searching for fern"
echo "searched for nmap, now searching for fern" >> /files/malware
dpkg -l | grep fern -i >> /files/malware #looks for fern installed
find / -iname "fern" -print >> /files/malware
ps aux | grep fern -i | grep -v grep >> /files/malware  #looks for fern running
echo "	" >> /files/malware  #Puts space in malware
echo "searched for fern, now searching for metasploit"
echo "searched for fern, now searching for metasploit" >> /files/malware
dpkg -l | grep metasploit -i >> /files/malware
find / -iname "metasploit" -print >> /files/malware
echo "	" >> /files/malware  #Puts space in malware
echo "searched for metasploit, now searching for backtrack"
echo "searched for metasploit, now searching for backtrack" >> /files/malware
dpkg -l | grep backtrack -i >> /files/malware
find / -iname "backtrack" -print >> /files/malware
echo "	" >> /files/malware  #Puts space in malware
echo "searched for backtrack, now searching for games"
echo "searched for backtrack, now searching for games" >> /files/malware
dpkg -l | grep game -i >> /files/malware
find / -iname "game" -print >> /files/malware
echo " " >> /files/malware
echo "searched for games, now searching for darkcomet"
echo "searched for games, now searching for darkcomet" >> /files/malware
find / -iname "darkcomet" -print >> /files/malware
echo "searched for darkcomet, now searching for files with the name password"
echo "searched for darkcomet, now searching for files with the name password" >> /files/malware
find / -iname "password" -print >> /files/malware
touch /files/services
dpkg -l | grep apache -i > /files/services
find / -iname "apache" -print >> /files/services
ps aux | grep apache -i | grep -v grep >> /files/services
echo "   " >> /files/services
echo "searched for apache, now searching for ssh"
echo "searched for apache, now searching for ssh" >> /files/services
dpkg -l | grep ssh -i | grep server -i >> /files/services
find / -iname "sshd" -print >> /files/services
find / -iname "openssh-server" -print >> /files/services
ps aux | grep ssh -i | grep -v grep >> /files/services
echo "   " >> /files/services
echo "searched for ssh, now searching for ftp"
echo "searched for ssh, now searching for ftp" >> /files/services
dpkg -l | grep ftp -i | grep server -i >> /files/services
ps aux | grep ftp -i | grep -v grep >> /files/services
echo "   " >> /files/services
echo "searched for ftp, now searching for dns"
echo "searched for ftp, now searching for dns" >> /files/services
dpkg -l | grep dns -i | grep server -i| grep -v "dnsmasq-base" >> /files/services
ps aux | grep dns -i | grep -v grep | grep -v "dnsmasq-base" >> /files/services
echo "   " >> /files/services
echo "searched for dns, now searching for samba"
echo "searched for dns, now searching for samba" >> /files/services
dpkg -l | grep samba -i | grep "SMB/CIFS file, print, and login server for Unix" >> /files/services
#find / -iname "samba" -print >> /files/services
ps aux | grep samba -i | grep -v grep >> /files/services
echo "   " >> /files/services
echo "searched for samba, now searching for dovecot"
echo "searched for samba, now searching for dovecot" >> /files/services
dpkg -l | grep dovecot -i >> /files/services
find / -iname "dovecot" -print >> /files/services
ps aux | grep dovecot -i | grep -v grep >> /files/services
echo "   " >> /files/services
#dpkg -l | grep cups -i >> /files/services
#ps aux | grep cups -i | grep -v grep >> /files/services
echo "   " >> /files/services
#dpkg -l | grep bind -i | grep -vi Binding >> /files/services
#ps aux | grep bind -i | grep -v grep >> /files/services
echo "   " >> /files/services
echo "searched for dovecot, now searching for nginx"
echo "searched for dovecot, now searching for nginx" >> /files/services
dpkg -l | grep nginx -i >> /files/services
ps aux | grep nginx -i | grep -v grep >> /files/services
echo "  " >> /files/services
echo "Backing up etc now"
if [ -d /backupetc ]; then
	cp /etc /backupetc -r
	echo "/backupetc already exist..etc has been backed up"
else
	mkdir /backupetc
	cp /etc /backupetc -r
	echo "etc has been backed up"
fi
echo "Moving on to backing up /home/"
if [ -d /backuphome ]; then
	cp /home/ /backuphome -r
	echo "/backuphome already exist..home/ has been backed up"
else
	mkdir /backuphome
	cp /home/ /backuphome -r
	echo "/home has been backed up"
fi
echo
shopt -s extglob #This is used so I can make exceptions in the move commands
echo
echo "adding the safety user"
adduser safety
adduser safety sudo
adduser safety adm
echo
echo "Setting the uninstall alias now"
alias uninstall='apt-get purge && apt-get autoremove'
echo "setting the update alias now"
alias update='apt-get update && apt-get upgrade'
echo
echo " Moving on to disable IPV6 "
if [ $(cat /proc/sys/net/ipv6/conf/all/disable_ipv6) = 1 ]; then
	echo "IPV6 is disabled already"
else
echo	net.ipv6.conf.all.disable_ipv6 = 1 >> /etc/sysctl.conf
echo	net.ipv6.conf.default.disable_ipv6 = 1 >> /etc/sysctl.conf
echo	net.ipv6.conf.lo.disable_ipv6 = 1 >> /etc/sysctl.conf
	sysctl -p
	if [ $(cat /proc/sys/net/ipv6/conf/all/disable_ipv6) = 1 ]; then
	echo "IPV6 is disabled"
	fi
fi
echo "       "
echo " Moving on to changing hosts file "
echo 127.0.0.1       localhost > /etc/hosts
echo 127.0.1.1 $(hostname) >> /etc/hosts
echo ::1     ip6-localhost ip6-loopback >> /etc/hosts
echo fe00::0 ip6-localnet >> /etc/hosts
echo ff00::0 ip6-mcastprefix >> /etc/hosts
echo ff02::1 ip6-allnodes >> /etc/hosts
echo ff02::2 ip6-allrouters >> /etc/hosts
echo "host file is done"
echo
#echo "changing /etc/resolv.conf now"
#echo "The above and below line should match"
#echo "nameserver 127.0.0.1"
#echo "if they do not match, check the end of /etc/dhcp/dhclient.conf
#or the end of /etc/resolvconf/resolv.conf.d/base & /etc/resolvconf/resolv.conf.d/head"
echo
echo "locking out root login now"
who | grep root
if [ $? -ne 0 ] ; then
	echo "root is not logged in"
	passwd -l root
else
	echo "root is logged in..why?"
fi
echo
echo
echo "Doing updates now"
apt-get -qq update -y --allow-unauthenticated > /dev/null && apt-get -qq upgrade -y --allow-unauthenticated > /dev/null && apt-get install -qq --reinstall coreutils unattended-upgrades auditd ufw openssl bum clamav auditd unhide libpam-cracklib -ym --allow-unauthenticated > /dev/null
dpkg-reconfigure -plow unattended-upgrades
pwconv
echo " just converted the password file"
echo
echo " changing permisisons of /etc, /shadow, and /etc/hosts now"
chmod 644 /etc/passwd
echo "changing permissions of passwd"
chmod 640 /etc/shadow
echo "changes permissions of shadow"
chown root:root /etc/hosts #changes permissions of hosts
chmod 644 /etc/hosts #Changes permissions of hosts
/etc/init.d/apparmor start #Start apparmor /files/services
echo "starting important services"
update-rc.d apparmor enable #sets apparmor to start at startup
update-rc.d syslog enable
update-rc.d rsyslog enable
service apparmor start
service syslog start
service rsyslog start

#Move UFW here
echo "Do you want john installed [y/n]"
read johninstalled
if [ $johninstalled == "y" ]; then
	echo "fine have your john"
fi
if [ $johninstalled == "n" ]; then
	apt-get purge john --auto-remove -y
	echo "john uninstalled, remember to stop john from running"
	ps aux | grep john | grep -v grep
	echo "If john is running, be sure to kill it"
fi
pwconv
ufw show listening | grep nc
if [ $? -ne 0 ]; then
echo "There does not seem to be a netcat backdoor"
else
echo "There is a netcat backdoor listening"
fi

echo " moving on to securing light dm"
if [ -a /etc/lightdm/lightdm.conf ]; then
	echo allow-guest=false >> /etc/lightdm/lightdm.conf
	echo "lightdm file existed"
else
	echo " light dm file did not exist"
fi
echo "securing ssh now if it is installed"
if [ -a /etc/ssh/sshd_config ]; then
	echo "ssh is probably installed"
	grep "permitrootlogin no" /etc/ssh/sshd_config -i
	if [ $? -ne 0 ]; then
		echo "root login is allowed through ssh"
	else
		echo "root login is not allowed through ssh"
	fi
	less /etc/ssh/sshd_config | grep protocol -i | grep 1
	if [ $? -ne 0 ]; then
		echo "Protocol 1 is not being used for SSH"
	else
		echo "Protcol 1 is being used for SSH"
	fi
	grep PermitEmptyPasswords /etc/ssh/sshd_config | grep yes -i
	if [ $? -ne 0 ]; then
		echo "empty passwords are not allowed"
	else
		echo "empty passwords are allowed"
	fi
fi
echo "ssh is secure"
touch /files/defaultusers
#echo news >> /files/defaultusers
echo "just made a list of default users"
touch /files/users
touch /files/differentusers
cut -d: -f1 /etc/passwd > /files/users
echo
echo "The users called games and news are default but you will want to remove them"
echo "Here are all the extra users on the system. should they be there?"
less /files/users | grep -v root | grep -v daemon | grep -v bin | grep -v clamav | grep -v rtkit | grep -v safety | grep -v utoipd | grep -v lord | grep -v pulse | grep -v hplip | grep -v colord | grep -v lightdm | grep -v avahi | grep -v speech-dispatcher | grep -v whoopsie | grep -v saned | grep -v kernoops | grep -v avahi-autoipd  | grep -v dnsmasq  | grep -v usbmux  | grep -v messagebus | grep -v syslog | grep -v libuuid | grep -v uuid | grep -v nobody | grep -v gnats | grep -v irc | grep -v list | grep -v backup | grep -v www-data | grep -v proxy | grep -v uucp | grep -v mail | grep -v lp | grep -v man | grep -v sync | grep -v sys | grep -v bin > /files/differentusers
cat /files/differentusers
echo
echo -n "Do you want to disable the games user [y/n]"
read gamesuser
if [ $gamesuser == "y" ]; then
	passwd -d games
	passwd -l games
	echo "games account has been disabled"
else
	echo "Games account has been left alone"
fi
echo
echo -n "Do you want to disable the news user [y/n]"
read newsuser
if [ $newsuser == "y" ]; then
  passwd -d news
  passwd -l news
else
  echo "news account was left alone"
fi
echo -n "enter exact name of bad user: "
read badusername1
echo
if [ ! -z "$badusername1" ]; then
  passwd -l $badusername1
  passwd -d $badusername1
  grep "$badusername1" /etc/gshadow
fi
#echo "moving $badusername1's home directory"
#mv /home/$badusername1 /quarantine -f
echo -n "enter exact name of bad user: "
read badusername2
echo
if [ ! -z "$badusername2" ]; then
  passwd -l $badusername2
  passwd -d $badusername2
  grep "$badusername2" /etc/gshadow
fi
#echo "moving $badusername2's home directory"
#mv /home/$badusername2 /quarantine -f

echo
echo -n "enter exact name of bad user: "
read badusername3
echo
if [ ! -z "$badusername3" ]; then
  passwd -l $badusername3
  passwd -d $badusername3
  grep "$badusername3" /etc/gshadow
fi
#echo "moving $badusername1's home directory"
#mv /home/$badusername3 /quarantine -f

echo
echo "this is the users in the sudo group"
grep "sudo" /etc/gshadow
echo "this is the users in the adm group"
grep "adm:" /etc/gshadow
echo "checking cron now"
echo
echo
if [ $(ls /etc/cron.daily | grep -v apt | grep -v cracklib-runtime | grep -v logrotate | grep -v mlocate | grep -v popularity-contest | grep -v update-notifier-common | grep -v "0anacron" | grep -v apport | grep -v bsdmainutils | grep -v dpkg | grep -v man-db | grep -v passwd | grep -v standard) == "" ]; then
	echo "cron.daily is okay"
else
	echo "There is something extra in cron.daily"
fi
echo
echo "cron.daily is done. checking cron.hourly"
echo
echo 
ls /etc/cron.hourly
if [ $? -ne 0 ] ; then
	echo "cron.hourly is okay"
else
	echo "There is something extra in cron.hourly"
fi
echo
echo
echo "cron.hourly is done. checking cron.weekly"
ls /etc/cron.weekly | grep -v 0anacron | grep -v apt | grep -v xapian-index | grep -v man-db
if [ $? -ne 0 ] ; then
	echo "cron.weekly is okay"
else
	echo "something extra is in cron.weekly"
fi
echo
echo "cron.weely done, checking cron.monthly now"
echo
ls /etc/cron.monthly | grep -v "0anacron"
if [ $? -ne 0 ] ; then
	echo "cron.monthly is okay"
else
	echo "something extra is in cron.monthly"
fi
echo "cron.monthly done..moving on to cron.d"
echo
echo
ls /etc/cron.d/ | grep -v anacron
if [ $? -ne 0 ] ; then
	echo "cron.d is okay"
else
	echo "something extra is in cron.d"
fi	
echo
#echo "moving on to pam.d"
#echo auth required pam_tally2.so deny=5 onerr=fail unlock_time=900 >> /etc/pam.d/common-auth
echo
echo "enabling auditing on the system"
auditctl –e 1
echo "auditing is enabled. Don't forget to edit /etc/audit/auditd.conf"
echo
dpkg -l | grep apache2 -i
if [ $? -ne 0 ] ; then
	echo "you are not an apache server"
else
	echo "you are an apache server"
	echo -n "enter y if you should be an apache server..enter n if  you should not be an apache server: [y/n] "
	read apacheserver
	if [ $apacheserver == "y" ] ; then
    		apt-get install apache2 -y
    		service apache2 start
		update-rc.d apache2 enable
		ufw allow apache2
		echo "apache install and service configured"
	fi
	if [ $apacheserver == "n" ] ; then
		apt-get purge apache2 --auto-remove -y
		update-rc.d apache2 remove
    		find /etc/cron* -iname "apache" -print
		echo "apache removed"
	fi
fi
dpkg -l | grep openssh-server
if [ $? -ne 0 ]; then
  echo "you are probably not a ssh server"
else
  echo "you are an ssh server"
  echo -n "Do you want to be an ssh server [y/n] "
  read sshserver
  if [ $sshserver == "y" ]; then
    apt-get install openssh-server -y
    service sshd start
    update-rc.d sshd enable
    ufw allow ssh
    echo "ssh server updated"
  fi
  if [ $sshserver == "n" ]; then
    apt-get purge openssh-server --auto-remove -y
    update-rc.d sshd remove
    ufw deny ssh
    echo "ssh server removed"
    find /etc/cron* -iname "ssh" -print
  fi
fi
dpkg -l | grep samba | grep "SMB/CIFS file, print, and login server for Unix"
if [ $? -ne 0 ]; then
  echo "you are probably not a samba server"
else
  echo "you are a samba server"
  echo -n "Do you want to be a samba server [y/n]"
  read sambaserver
  if [ $sambaserver == "y" ]; then
    apt-get install samba -y
    service samba start
    update-rc.d samba enable
    ufw allow samba
    echo "samba has been configured"
  fi
  if [ $sambaserver == "n" ]; then
    apt-get purge samba -y
    service samba stop
    update-rc.d samba remove
    ufw deny samba
    echo "samba has been removed"
#   find /etc/cron* -iname "samba" -print
  fi
fi
#Looks for php backdoors
echo "looking for php backdoors now"
touch /files/phpbackdoors
find / -iname "*.php" -print -exec grep "exec" -i {} + > /files/phpbackdoors
find / -iname "*.php" -print -exec grep "CMD" -i {} + >> /files/phpbackdoors
find / -iname "*.php" -print -exec grep "shell" -i {} + >>/files/phpbackdoors
echo "The script is done. Make sure you check the files called mediafiles, malware, services, and phpbackdoors that are located in /files/ "
