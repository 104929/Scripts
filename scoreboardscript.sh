#!/bin/bash
#counter=$((counter+1))
counter=2820
while [ $counter -le 3380 ]; do
#http://scoreboard.uscyberpatriot.org/team.php?$(grep "FL" index.php\?sort\=Division | grep -v Middle | grep -v All | grep -o team=08-$n)
  teamnum=$(less index.php\?sort\=Number | grep All | grep -o team=08-$counter)
  #echo "$teamnum"
  if [ $? -eq 0 ]; then
    curl http://scoreboard.uscyberpatriot.org/team.php?$teamnum -O --globoff
  fi
#  echo "$teamnum"
  #curl http://scoreboard.uscyberpatriot.org/team.php?[${teamnum}] -O
  counter=$((counter+1))
done


#curl http://scoreboard.uscyberpatriot.org/team.php?[0000-3379]
#http://scoreboard.uscyberpatriot.org/team.php?team=08-2685
#teamnum=$(cat index.php\?sort\=Number | grep FL | grep Open | grep -o team=08-$counter)
