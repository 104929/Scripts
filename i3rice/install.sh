#!/bin/bash
echo "Welcome to the our Ubuntu i3wm ricing installer!"
echo ""
echo "This script will install or update any neccary packages, (and it will do updates, so it may take a little while) and move the neccasary files to your home directory."
echo "Do not run this script as root, the files will not be copied into your home directory if you are root."
echo -n "Do you want to proceed? y/n"
read choice
if [ -z $choice ]; then
	exec bash "$0"
fi
if [ $choice == "y" ]; then
  # Installs arc theme repo and installs all packages needed
  sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/arc-theme.list"
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get install -y i3 i3blocks i3lock lxappearance arandr lxrandr atom feh rxvt-unicode compton arc-theme firefox

  # Moves dirs into home directory
  mv ./.i3/ ~/
  mv ./.fonts/ ~/
  mv ./.Xresources ~/
  mv ./.gtkrc-2.0 ~/
  mv ./.config ~/

	# sets up urxvt
	xrdb ~/.Xresources

	# asks user to reboot
	read reboot
	if [ $reboot == "y" ]; then
		sudo reboot
	else
		exit
	fi

fi

if [ $choice == "n" ]; then
	exit
fi
