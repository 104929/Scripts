#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo "You are root"
else
  echo "you are not root"
	exit 1
fi
echo "Welcome to the Cyberpatriot Round One Replica!"
echo "Test add"
echo "test two"
