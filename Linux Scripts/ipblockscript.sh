#!/bin/bash
echo -n "Enter bad IP"
read badip
ufw insert 1 deny in from $badip
ufw insert 1 deny out to $badip
