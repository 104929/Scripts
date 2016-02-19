#!/bin/bash
echo "Make sure you are done with the Forensics Questions before running the script "
if [ $(whoami) = "root" ]; then
	echo "You are root"
else
  echo "you are not root"
	exit 1
fi
if [ ! -d /files ]; then
  mkdir /files
fi
touch /files/log.log
updatedb
echo "What would you like to do?"
echo "Enter a number 1-25 to select a choice:"
echo "1 for checking commands"
echo "2 for recon"
echo "3 for making /etc/ and /home/ backups"
echo "4 for managing login.defs"
echo "5 for user managment"
echo "6 for updates"
echo "7 for making a safety account "
echo "8 for managing cron "
echo "9 for locking out root account"
echo "10 for managing ftp"
echo "11 to disable IPv6"
echo "12 to uninstall john"
echo "13 to look for a netcat backdoor"
echo "14 to secure lightdm on 12.04"
echo "15 to manage ssh"
echo "16 to manage samba"
echo "17 to look for backdoors"
echo "18 to manage apache"
echo "19 to make a quarantine folder"
echo "20 to search for malware"
echo "21 to set up ufw"
echo "22 to set alias's"
echo "23 to set default permissions for /etc/ & /etc/shadow & /etc/host"
echo "24 to start apparmor and system logging"
echo "25 to enable auditing"
echo "26 to check sudoers.d"
echo "27 to check pam.d"
echo "28 to manage an SQL Server"
echo "29 to make John cry"
echo -n "Choice: "
read choice
#Checks Commands
if [ -z $choice ]; then
	exec bash "$0"
fi
if [ $choice == "1" ]; then
  alias | grep -v "alias egrep='egrep --color=auto'" | grep -v "alias fgrep='fgrep --color=auto'" | grep -v "alias grep='grep --color=auto'" | grep -v "alias l='ls -CF'" | grep -v "alias la='ls -A'" | grep -v "alias ll='ls -alF'" | grep -v "alias ls='ls --color=auto'"
  if [ $? -eq 0 ]; then
  	echo "alias is good"
  	echo
  fi
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
  echo
  if [ $(which sudo) == "/usr/bin/sudo" ]; then
  	echo "sudo is good"
  else
  	echo "sudo is bad"
  	alias sudo='/usr/bin/sudo'
  fi
  echo
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
  echo "Commands have been checked"
fi
#Does Recon
if [ $choice == "2" ]; then
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
  find / -iname "*.wma" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.flv" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.mov" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.avi" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.mpeg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.mpg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.jpeg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.jpg" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.png" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.psd" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.bmp" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.gif" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.tif" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.tiff" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.rec" -print | grep -v /usr/share | grep -v lib | grep -v quarantine  >> /files/mediafiles
  find / -iname "*.mkv" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/mediafiles
  touch /files/malware
  echo "Remember the alias of uninstall to remove any of these packages"
  netstat -anp | grep -i "rat" >> /files/malware
  netstat -tulnp | grep -i "rat" >> /files/malware
  dpkg -l | grep john -i > /files/malware #Looks for. john installed
  ps aux | grep john -i | grep -v grep >> /files/malware #looks for john running
  lsof | grep /etc/passwd >> /files/malware
  lsof | grep shadow >> /files/malware
  find /etc/cron* -iname "john" -print
  find / -iname "*.pot" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/malware
  find / -iname "*.rec" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/malware
  find / -iname "john" -print | grep -v /usr/share | grep -v lib | grep -v quarantine >> /files/malware
  echo "Searched for john, now searching for hydra"
  echo "Searched for john, now searching for hydra" >> /files/malware
  echo "	" >> /files/malware #puts space in malware
  dpkg -l | grep hydra -i >> /files/malware #looks for hydra installed
  ps aux | grep hydra -i | grep -v grep >> /files/malware #looks for hydra running
  find / -iname "hydra" -print >> /files/malware
  echo "Searched for hydra, now searching for netcat" >> /files/malware
  echo "Searched for hydra, now searching for netcat"
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
  echo "Searched for netcat, now searching for cain & abel"
  echo "Searched for netcat, now searching for cain & abel" >> /files/malware
  #ps aux | grep nc -i | grep -v grep >> /files/malware #looks for nc running
  echo "	" >> /files/malware  #Puts space in malware
  dpkg -l | grep cain -i >> /files/malware #looks for cain installed
  find / -iname "cain" -print >> /files/malware
  #dpkg -l | grep abel -i >> /files/malware #looks for abel installed
  #find / -iname "abel" -print >> /files/malware
  ps aux | grep cain -i | grep -v grep >> /files/malware #look for cain running
  #ps aux | grep abel -i | grep -v grep >> /files/malware #looks for abel running
  echo "Searched for cain & abel, now searching for medusa"
  echo "Searched for cain & abel, now searching for medusa" >> /files/malware
  echo "	" >> /files/malware  #Puts space in malware
  dpkg -l | grep medusa -i >> /files/malware #Looks for medusa installed
  find / -iname "medusa" -print >> /files/malware
  ps aux | grep medusa -i | grep -v grep >> /files/malware #Looks for medusa running
  echo "	" >> /files/malware  #Puts space in malware
  echo "Searched for medusa, now searching for aircrack"
  echo "Searched for medusa, now searching for aircrack" >> /files/malware
  dpkg -l | grep aircrack -i >> /files/malware #Looks for aircrack installed
  find / -iname "aircrack" -print >> /files/malware
  ps aux | grep aircrack -i | grep -v grep >> /files/malware  #looks for aircrack running
  echo "	" >> /files/malware	  #Puts space in malware
  echo "Searched for aircrack, now searching for nmap"
  echo "Searched for aircrack, now searching for nmap" >> /files/malware
  dpkg -l | grep nmap -i >> /files/malware #looks for nmap installed
  find / -iname "nmap" -print >> /files/malware
  ps aux | grep nmap -i | grep -v grep >> /files/malware  #looks for nmap running
  echo "	" >> /files/malware  #Puts space in malware
  echo "Searched for nmap, now searching for fern"
  echo "Searched for nmap, now searching for fern" >> /files/malware
  dpkg -l | grep fern -i >> /files/malware #looks for fern installed
  find / -iname "fern" -print >> /files/malware
  ps aux | grep fern -i | grep -v grep >> /files/malware  #looks for fern running
  echo "	" >> /files/malware  #Puts space in malware
  echo "Searched for fern, now searching for metasploit"
  echo "Searched for fern, now searching for metasploit" >> /files/malware
  dpkg -l | grep metasploit -i >> /files/malware
  find / -iname "metasploit" -print >> /files/malware
  echo "	" >> /files/malware  #Puts space in malware
  echo "Searched for metasploit, now searching for backtrack"
  echo "Searched for metasploit, now searching for backtrack" >> /files/malware
  dpkg -l | grep backtrack -i >> /files/malware
  find / -iname "backtrack" -print >> /files/malware
  echo "	" >> /files/malware  #Puts space in malware
  echo "Searched for backtrack, now searching for games"
  echo "Searched for backtrack, now searching for games" >> /files/malware
  dpkg -l | grep game -i >> /files/malware
  find / -iname "game" -print >> /files/malware
  echo " " >> /files/malware
  echo "Searched for games, now searching for darkcomet"
  echo "Searched for games, now searching for darkcomet" >> /files/malware
  find / -iname "darkcomet" -print >> /files/malware
  echo "Searched for darkcomet, now searching for files with the name password"
  echo "Searched for darkcomet, now searching for files with the name password" >> /files/malware
  find / -iname "password" -print >> /files/malware
  echo "Searched for files with the name password, now searching for kismet"
  echo "Searched for files with the name password, now searching for kismet" >> /files/malware
  dpkg -l | grep kismet -i >> /files/malware
  ps aux | grep kismet -i | grep -v grep >> /files/malware
  find / -iname "kismet" -print >> /files/malware
  echo "Searched for kismet, now searching for telnet"
  echo "Searched for kismet, now searching for telnet" >> /files/malware
  dpkg -l | grep telnet -i >> /files/malware
  ps aux | grep telnet -i | grep -v "grep" >> /files/malware
  find  / -iname "telnet" -print >> /files/malware
  echo "Done searching for malware, now searching for services running on the computer"
  touch /files/services
  dpkg -l | grep apache -i > /files/services
  find / -iname "apache" -print >> /files/services
  ps aux | grep apache -i | grep -v grep >> /files/services
  echo "   " >> /files/services
  echo "Searched for apache, now searching for ssh"
  echo "Searched for apache, now searching for ssh" >> /files/services
  dpkg -l | grep ssh -i | grep server -i >> /files/services
  find / -iname "sshd" -print >> /files/services
  find / -iname "openssh-server" -print >> /files/services
  ps aux | grep ssh -i | grep -v grep >> /files/services
  echo "   " >> /files/services
  echo "Searched for ssh, now searching for ftp"
  echo "Searched for ssh, now searching for ftp" >> /files/services
  dpkg -l | grep ftp -i | grep server -i >> /files/services
  ps aux | grep ftp -i | grep -v grep >> /files/services
  echo "   " >> /files/services
  echo "Searched for ftp, now searching for dns"
  echo "Searched for ftp, now searching for dns" >> /files/services
  dpkg -l | grep dns -i | grep server -i| grep -v "dnsmasq-base" >> /files/services
  ps aux | grep dns -i | grep -v grep | grep -v "dnsmasq-base" >> /files/services
  echo "   " >> /files/services
  echo "Searched for dns, now searching for samba"
  echo "Searched for dns, now searching for samba" >> /files/services
  dpkg -l | grep samba -i | grep "SMB/CIFS file, print, and login server for Unix" >> /files/services
  #find / -iname "samba" -print >> /files/services
  ps aux | grep samba -i | grep -v grep >> /files/services
  echo "   " >> /files/services
  dpkg -l | grep smtp -i >> /files/services
  ps aux | grep smtp -i | grep -v grep >> /files/services
  netstat -tulnp | grep smtp -i >> /files/services
  echo "   " >> /files/services
  echo "Searched for samba, now searching for dovecot"
  echo "Searched for samba, now searching for dovecot" >> /files/services
  dpkg -l | grep dovecot -i >> /files/services
  find / -iname "dovecot" -print >> /files/services
  ps aux | grep dovecot -i | grep -v grep >> /files/services
  netstat -tulnp | grep dovecot -i >> /files/services
  echo "   " >> /files/services
  dpkg -l | grep snmp -i >> /files/services
  ps aux | grep snmp -i | grep -v grep >> /files/services
  netstat -tulnp | grep snmp -i >> /files/services
  echo "   " >> /files/services
  dpkg -l | grep cupsd -i >> /files/services
  ps aux | grep cupsd -i | grep -v grep >> /files/services
  find / -iname "cupsd" -print  | grep -v /usr/sbin/cupsd >> /files/services
  netstat -tulnp | grep -i "cupsd" >> /files/services
  echo "   " >> /files/services
  dpkg -l | grep bind9 -i | grep -vi Binding >> /files/services
  ps aux | grep bind9 -i | grep -v grep >> /files/services
  find / -iname "bind9" -print | grep -v "/usr/lib/" >> /files/services
  netstat -tulnp | grep -i "bind" >> /files/services
  echo "   " >> /files/services
  dpkg -l | grep nginx -i >> /files/services
  ps aux | grep nginx -i | grep -v "grep" >> /files/services
  find / -iname "nginx" -print >> /files/services
  echo "   " >> /files/services
  dpkg -l | grep mariadb -i >> /files/services
  ps aux | grep mariadb -i | grep -v "grep" >> /files/services
  find / -iname "mariadb" -print >> /files/services
  echo "	" >> /files/services
  dpkg -l | grep sql -i | grep server -i >> /files/services
  ps aux | grep sql | grep -v "grep" >> /files/services
  dpkg -l | grep vnc -i >> /files/services
  ps aux | grep vnc -i | grep -v grep
  echo "	" >> /files/services
  echo "Make sure you check the files called mediafiles, malware, services, and backdoors that are located in /files/ "
fi
#Back up /etc and /home
if [ $choice == "3" ]; then
  echo "Backing up etc now"
  if [ -d /backupetc ]; then
#  	cp /etc /backupetc -r
  	echo "/backupetc already exist..etc has been backed up"
  else
  	mkdir /backupetc
  	cp /etc /backupetc -r
  	echo "etc has been backed up"
  fi
  echo "Moving on to backing up /home/"
  if [ -d /backuphome ]; then
#  	cp /home/ /backuphome -r
  	echo "/backuphome already exist..home/ has been backed up"
  else
  	mkdir /backuphome
  	cp /home/ /backuphome -r
  	echo "/home has been backed up"
  fi
fi
#Manages login.defs
if [ $choice == "4" ]; then
	cat /etc/login.defs | grep "PASS_MAX_DAYS" | grep "90" >> /dev/null
	if [ $? -ne 0 ]; then
		echo "You need to set the Password Maximum days in /etc/login.defs"
	fi
	cat /etc/login.defs | grep "PASS_MIN_DAYS" | grep "10" >> /dev/null
	if [ $? -ne 0 ]; then
		echo "You need to set the Password Minimum days in /etc/login.defs"
	fi
	cat /etc/login.defs | grep "PASS_WARN_AGE" | grep "7" >> /dev/null
	if [ $? -ne 0 ]; then
		echo "You need to set the PASS_WARN_AGE back to 7"
	fi
	cat /etc/login.defs | grep "UID_MIN" | grep "1000" >> /dev/null
	if [ $? -ne 0 ]; then
		echo "You need to change UID_MIN back to 1000"
	fi
	cat /etc/login.defs | grep "ENCRYPT_METHOD" | grep "SHA512" | grep -v "#" >> /dev/null
	if [ $? -ne 0 ]; then
		echo "You need to change ENCRYPT_METHOD back to SHA512"
	fi
	cat /etc/login.defs | grep "LOGIN_TIMEOUT" | grep "60" >> /dev/null
	if [ $? -ne 0 ]; then
		echo "You need to change LOGIN_TIMEOUT back to 60"
	fi
fi
#Looks for the bad users on the system
if [ $choice == "5" ]; then
  touch /files/defaultusers
  #echo news >> /files/defaultusers
  echo "Just made a list of default users"
  touch /files/users
  touch /files/differentusers
  cut -d: -f1 /etc/passwd > /files/users
  echo
  echo "The users called games and news are default but you will want to remove them"
  echo "Here are all the extra users on the system. should they be there?"
  less /files/users | grep -v root | grep -v daemon | grep -v bin | grep -v clamav | grep -v rtkit | grep -v safety | grep -v utoipd | grep -v lord | grep -v pulse | grep -v hplip | grep -v colord | grep -v lightdm | grep -v avahi | grep -v speech-dispatcher | grep -v whoopsie | grep -v saned | grep -v kernoops | grep -v avahi-autoipd  | grep -v dnsmasq  | grep -v usbmux  | grep -v messagebus | grep -v syslog | grep -v libuuid | grep -v uuid | grep -v nobody | grep -v gnats | grep -v irc | grep -v list | grep -v backup | grep -v www-data | grep -v proxy | grep -v uucp | grep -v mail | grep -v lp | grep -v man | grep -v sync | grep -v sys | grep -v bin > /files/differentusers
  cat /files/differentusers
  echo -n "Enter exact name of bad user: "
  read badusername1
  echo
  if [ ! -z "$badusername1" ]; then
    passwd -l $badusername1
    passwd -d $badusername1
    grep "$badusername1" /etc/gshadow
  fi
  echo "Remember to move $badusername1's home directory to quarantine"
  #mv /home/$badusername1 /quarantine -f
  echo -n "Enter exact name of bad user: "
  read badusername2
  echo
  if [ ! -z "$badusername2" ]; then
    passwd -l $badusername2
    passwd -d $badusername2
    grep "$badusername2" /etc/gshadow
  fi
  echo "Remember to move $badusername2's home directory to quarantine"
  #mv /home/$badusername2 /quarantine -f

  echo
  echo -n "Enter exact name of bad user: "
  read badusername3
  echo
  if [ ! -z "$badusername3" ]; then
    passwd -l $badusername3
    passwd -d $badusername3
    grep "$badusername3" /etc/gshadow
  fi
  #echo "Remember to move $badusername3's home directory to quarantine"
  #mv /home/$badusername3 /quarantine -f
  echo -n "Do you want to disable the games user [y/n]"
  read gamesuser
 if [ $gamesuser == "y" ]; then
  	passwd -d games
  	passwd -l games
  	echo "Games account has been disabled"
  else
  	echo "Games account has been left alone"
  fi
  echo
  echo "Do you want to disable the news user [y/n]"
  read newsuser
  if [ $newsuser == "y" ]; then
    passwd -d news
    passwd -l news
  else
    "News account was left alone"
  fi
  echo "This is the users in the sudo group"
  grep "sudo" /etc/gshadow
  echo "This is the users in the adm group"
  grep "adm:" /etc/gshadow
  if [ ! -e /etc/security/opasswd ]; then
  	touch /etc/security/opasswd
  fi
fi
#Does updates
if [ $choice == "6" ]; then
  echo "Doing updates now"
  apt-get -qq update -y --allow-unauthenticated > /dev/null && apt-get -qq upgrade -y --allow-unauthenticated > /dev/null && apt-get install -qq --reinstall coreutils auditd ufw gufw aptitude openssl bum clamav unhide bash openssl libssl-dev libpam-cracklib apparmor apparmor-profiles -ym --allow-unauthenticated > /dev/null
fi
#Makes a safety account
if [ $choice == "7" ]; then
  adduser safety
  adduser safety sudo
  adduser safety adm
fi
#Does cron
if [ $choice == "8" ]; then
  ls /etc/cron.daily | grep -v apt | grep -v spamassassin | grep -v upstart | grep -v cracklib-runtime | grep -v logrotate | grep -v mlocate | grep -v popularity-contest | grep -v update-notifier-common | grep -v "0anacron" | grep -v apport | grep -v bsdmainutils | grep -v dpkg | grep -v man-db | grep -v passwd | grep -v standard
  if [ $? -ne 0 ]; then
  	echo "cron.daily is okay"
  else
  	echo "There is something extra in cron.daily"
  fi
  echo
  echo "cron.daily is done. checking cron.hourly"
  echo
  echo
  ls /etc/cron.hourly
  if [ $? -eq 0 ] ; then
  	echo "cron.hourly is okay"
  else
  	echo "There is something extra in cron.hourly"
  fi
  echo
  echo
  echo "cron.hourly is done. checking cron.weekly"
  ls /etc/cron.weekly | grep -v fstrim | grep -v "update-notifier-common" | grep -v "0anacron" | grep -v apt | grep -v xapian-index | grep -v man-db
  if [ $? -ne 0 ] ; then
  	echo "cron.weekly is okay"
  else
  	echo "Something extra is in cron.weekly"
  fi
  echo
  echo "cron.weely done, checking cron.monthly now"
  echo
  ls /etc/cron.monthly | grep -v "0anacron"
  if [ $? -ne 0 ] ; then
  	echo "cron.monthly is okay"
  else
  	echo "Something extra is in cron.monthly"
  fi
  echo "cron.monthly done..moving on to cron.d"
  echo
  echo
  ls /etc/cron.d/ | grep -v anacron
  if [ $? -ne 0 ] ; then
  	echo "cron.d is okay"
  else
  	echo "Something extra is in cron.d"
  fi
fi
#Locks out root login
if [ $choice == "9" ]; then
  echo "Locking out root login now"
  who | grep root
  if [ $? -ne 0 ] ; then
  	echo "Root is not logged in"
  	passwd -dl root
  else
  	echo "Root is logged in..why?"
  fi
fi
#Manages FTP
if [ $choice == "10" ]; then
	if [ -e /etc/vsftpd.conf ]; then
		echo "You are probably an ftp server"
		echo -n "Do you want to be an ftp server [y/n]"
		read ftpserver
		if [ $ftpserver == "y" ]; then
			apt-get install vsftpd
			if [ -e /etc/vsftpd.conf ]; then
				less /etc/vsftpd.conf | grep "anonymous_enable" | grep NO >> /dev/null
				if [ $? -ne 0 ]; then
					echo "Anonymous users are allowed in /etc/vsftpd.conf. Fix this by changing anonymous_enable to =NO "
				fi
				less /etc/vsftpd.conf | grep "anon_upload_enable=YES" | grep "#"
				if [ $? -ne 0 ]; then
					echo "Anonymous file upload is allowed in /etc/vsftpd.conf. Fix this by commenting out anon_upload_enable=YES "
				fi
				less /etc/vsftpd.conf | grep "anon_mkdir_write_enable=YES" | grep "#"
				if [ $? -ne 0 ]; then
					echo "Anonymous users are allowed to create directories in /etc/vsftpd.conf. Fix this by commenting out anon_mkdir_write_enable=YES "
				fi
			fi
			ufw allow ftp
		fi
		if [ $ftpserver = "n" ]; then
			apt-get purge vsftpd --auto-remove
			service vsftpd stop
			update-rc.d vsftpd remove
			ufw deny ftp
		fi
	else
		dpkg -l | grep vsftpd
			if [ $? -eq 0 ]; then
				echo "Vsftpd is installed but /etc/vsftpd.conf does not exist "
			else
				echo "Vsftpd does not appear to be installed"
			fi
	fi
fi
#Disables IPV6
if [ $choice == "11" ]; then
  echo "Going to disable IPV6 "
  if [ $(cat /proc/sys/net/ipv6/conf/all/disable_ipv6) = 1 ]; then
  	echo "IPV6 is disabled already"
  else
  echo	net.ipv6.conf.all.disable_ipv6 = 1 >> /etc/sysctl.conf
  echo	net.ipv6.conf.default.disable_ipv6 = 1 >> /etc/sysctl.conf
  echo	net.ipv6.conf.lo.disable_ipv6 = 1 >> /etc/sysctl.conf
  	sysctl -p
  	if [ $(cat /proc/sys/net/ipv6/conf/all/disable_ipv6) = 1 ]; then
  		echo "IPV6 is disabled"
  	else
  		exec bash "$0"
  	fi
  fi
fi
#Get rid of john
if [ $choice == "12" ]; then
  echo "Do you want john installed [y/n]"
  read johninstalled
  if [ $johninstalled == "y" ]; then
  	echo "Fine have your john"
  fi
  if [ $johninstalled == "n" ]; then
  	apt-get purge john --auto-remove -y
  	echo "John uninstalled, remember to stop john from running"
  	ps aux | grep john | grep -v grep
  	echo "If john is running, be sure to kill it"
    pwconv
  fi
fi
#Find a netcat backdoor
if [ $choice == "13" ]; then
  ufw show listening | grep nc
  if [ $? -ne 0 ]; then
  echo "There does not seem to be a netcat backdoor"
  else
  echo "There is a netcat backdoor listening"
  fi
fi
#Secure Lightdm on 12.04
if [ $choice == "14" ]; then
  echo "Moving on to securing light dm"
  if [ -a /etc/lightdm/lightdm.conf ]; then
  	echo allow-guest=false >> /etc/lightdm/lightdm.conf
  	echo "Lightdm file existed"
  else
  	echo "Light dm file did not exist"
  fi
fi
#Manage sshd
if [ $choice == "15" ]; then
  dpkg -l | grep openssh-server
  if [ $? -ne 0 ]; then
    echo "You are probably not a ssh server"
  else
    echo "You are an ssh server"
    echo -n "Do you want to be an ssh server [y/n] "
    read sshserver
    if [ $sshserver == "y" ]; then
      apt-get install openssh-server -y
      service sshd start
      update-rc.d sshd enable
      ufw allow ssh
      echo "SSH server updated"
      echo "Now checking how secure sshd_config is"
      echo "Securing ssh now if it is installed"
      if [ -a /etc/ssh/sshd_config ]; then
      	echo "SSH is probably installed"
      	grep "permitrootlogin no" /etc/ssh/sshd_config -i
      	if [ $? -ne 0 ]; then
      		echo "Root login is allowed through ssh"
      	else
      		echo "Root login is not allowed through ssh"
      	fi
      	less /etc/ssh/sshd_config | grep protocol -i | grep 1
      	if [ $? -ne 0 ]; then
      		echo "Protocol 1 is not being used for SSH"
      	else
      		echo "Protcol 1 is being used for SSH"
      	fi
      	grep PermitEmptyPasswords /etc/ssh/sshd_config | grep yes -i
      	if [ $? -ne 0 ]; then
      		echo "Empty passwords are not allowed"
      	else
      		echo "Empty passwords are allowed"
      	fi
      	grep LoginGraceTime /etc/ssh/sshd_config | grep 10
      	if [ $? -ne 0 ]; then
			echo "You need to secure login grace time in /etc/ssh/sshd_config"
		fi
      fi
      echo "ssh is secure"
    fi
    if [ $sshserver == "n" ]; then
      apt-get purge openssh-server --auto-remove -y
      update-rc.d sshd remove
      ufw deny ssh
      echo "SSH server removed"
      find /etc/cron* -iname "ssh" -print
    fi
  fi
fi
#Manage samba
if [ $choice == "16" ]; then
  dpkg -l | grep samba | grep "SMB/CIFS file, print, and login server for Unix"
  if [ $? -ne 0 ]; then
    echo "You are probably not a samba server"
  else
    echo "You are a samba server"
    echo -n "Do you want to be a samba server [y/n]"
    read sambaserver
    if [ $sambaserver == "y" ]; then
      apt-get install samba -y
      service samba start
      update-rc.d samba enable
      ufw allow samba
      echo "Samba has been configured"
    fi
    if [ $sambaserver == "n" ]; then
      apt-get purge samba -y
      service samba stop
      update-rc.d samba remove
      ufw deny samba
      echo "Samba has been removed"
  #   find /etc/cron* -iname "samba" -print
    fi
  fi
fi
#Look for a backdoor
if [ $choice == "17" ]; then
  #Looks for backdoors
  echo "Looking for backdoors now"
  touch /files/backdoors
  find / -iname "*.php" -print -exec grep "(exec|CMD|shell|system|passthru)" -i {} + >> /files/backdoors
  find / -iname "*.pl" -print -exec grep "(exec|CMD|shell|system|passthru)" -i {} + >> /files/backdoors
  cat /files/backdoors | grep -v "/var/cache/dictionaries-common/sqspell.php"
  #find / -iname "*.php" -print -exec grep "CMD" -i {} + >> /files/phpbackdoors
  #find / -iname "*.php" -print -exec grep "shell" -i {} + >> /files/phpbackdoors
  #find / -iname "*.php" -print -exec grep "system" -i {} + >> /files/phpbackdoors
  #find / -iname "*.php" -print -exec grep "passthru" -i {} + >> /files/phpbackdoors
fi
#Manage apache
if [ $choice == "18" ]; then
  dpkg -l | grep apache2 -i
  if [ $? -ne 0 ] ; then
  	echo "You are not an apache server"
  else
  	echo "You are an apache server"
  	echo -n "Enter y if you should be an apache server..enter n if  you should not be an apache server: [y/n] "
  	read apacheserver
  	if [ $apacheserver == "y" ] ; then
			apt-get install apache2 -y
			apt-get install libapache2-modsecurity -y
    	service apache2 start
  		update-rc.d apache2 enable
  		ufw allow apache2
			chmod u+rwx /var/www/html/
			chmod g+rx /var/www/html/ && chmod g-w /var/www/html/
			chmod o+rx /var/www/html/ && chmod o-w /var/www/html/
  		echo "Apache install and service configured"
  	fi
  	if [ $apacheserver == "n" ] ; then
  		apt-get purge apache2 --auto-remove -y
  		update-rc.d apache2 remove
      		find /etc/cron* -iname "apache" -print
  		echo "Apache removed"
  	fi
  fi
fi
#Make /quarantine folder
if [ $choice == "19" ]; then
  echo " Moving on to making the quarantine folder"
  if [ -d /quarantine ]; then
  	echo "/quarantine folder is already made"
  else
  	mkdir /quarantine
  fi

fi
#Searches for malware
if [ $choice == "20" ]; then
  echo -n "Enter the name of malware to search for: "
  read malware
  dpkg -l | grep $malware
  echo
  ps aux | grep $malware | grep -v grep
fi
#Sets up ufw
if [ $choice == "21" ]; then
  echo "Managing ufw now"
  ufw enable
  ufw logging on
  ufw logging high
  ufw reload
  ufw status verbose | grep Default | grep -v "Default: deny (incoming), allow (outgoing), disabled (routed)"
  if [ $? -ne 0 ] ; then
  	echo "Ufw is not at the Default configuration"
  fi
fi
#Sets alias's
if [ $choice == "22" ]; then
  echo "Setting the uninstall alias now"
  alias uninstall='apt-get purge && apt-get autoremove'
  echo "Setting the update alias now"
  alias update='apt-get update && apt-get upgrade'
fi
#Changing permisisons of /etc, /etc/shadow, and /etc/hosts
if [ $choice == "23" ]; then
  chmod 644 /etc/passwd
  echo "Changing permissions of passwd"
  chmod 640 /etc/shadow
  echo "Changes permissions of shadow"
  chown root:root /etc/hosts #changes permissions of hosts
  chmod 644 /etc/hosts #Changes permissions of hosts
fi
#Starting apparmor, syslog, and rsyslog
if [ $choice == "24" ]; then
  /etc/init.d/apparmor start #Start apparmor /files/services
  echo "Starting important services"
  update-rc.d apparmor defaults
  update-rc.d apparmor enable #sets apparmor to start at startup
  update-rc.d syslog defaults
  update-rc.d syslog enable
  update-rc.d rsyslog defaults
  update-rc.d rsyslog enable
  service apparmor start
  service syslog start
  service rsyslog start
fi
#Enable auditing
if [ $choice == "25" ]; then
  apt-get install -ymqq --allow-unauthenticated auditd
  auditctl –e 1
fi
if [ $choice == "26" ]; then
	ls /etc/sudoers.d | grep -v README >> /dev/null
	if [ $? -eq 0 ]; then
		echo "There is something extra in /etc/sudoers.d"
	else
		echo "sudoers.d is good"
	fi
fi
if [ $choice == "27" ]; then
  cat /etc/pam.d/common-password | grep "sha512" >> /dev/null
  if [ $? -ne 0 ]; then
    echo "Change then encryption in /etc/pam.d/common-password to sha512"
  fi
  cat /etc/pam.d/common-password | grep "minlen=8" | grep "remember=5" >> /dev/null
  if [ $? -ne 0 ]; then
    echo "change minlen=? to minlen=8 and add remember=5 in /etc/pam.d/common-password"
  fi
  cat /etc/pam.d/common-password | grep "lcredit=-1" >> /dev/null
  if [ $? -ne 0 ]; then
    echo "Add lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1 line to /etc/pam.d/common-password"
  fi
  cat /etc/pam.d/common-auth | grep "auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800" >> /dev/null
  if [ $? -ne 0 ]; then
    echo "Add the  auth required pam_tally2.so deny=5 onerr=fail unlock_time=1800  line to the end of /etc/pam.d/common-auth"
  fi
fi
if [ $choice == "28" ]; then
	dpkg -l | grep "(mysql-server|mariadb)" -i
	if [ $? -ne 0 ] ; then
		echo "You are not a mysql server"
	else
		echo "You are a mysql server"
		echo -n "Enter y if you should be a sql server..enter n if  you should not be a sql server: [y/n] "
		read sqlserver
		if [ $sqlserver == "y" ] ; then
			apt-get install mysql-server --reinstall -y
			apt-get install mariadb-server --reinstall -y
			service mysql start
			service mariadb start
			update-rc.d mysql enable
			update-rc.d mariadb enable
			ufw allow mysql
			ufw allow mariadb
			/usr/bin/mysql_secure_installation
		fi
		if [ $sqlserver == "n" ] ; then
			apt-get purge -ymqq --allow-unauthenticated mysql-server mariadb-server
			update-rc.d mysql remove
			find /etc/cron* -iname "SQL" -print
			find /etc/cron* -iname "maria" -print
			echo "SQL server removed"
		fi
	fi
fi
#if [ $choice == "29" ]; then
#	apt-get install mpv >> /dev/null
#	mpv https://youtu.be/9lS83kehLWU 
#	wget https://cdn.discordapp.com/attachments/95342781723062272/142448607549718528/IMG_1454032792210-331074273.jpg -O /usr/share/john.jpg
#	gsettings set org.gnome.desktop.background picture-uri file:///usr/share/john.jpg
#fi
echo "Press Control + Z to exit the script"
exec bash "$0"
