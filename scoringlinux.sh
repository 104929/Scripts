#!/bin/bash
score=0
ufw status | grep inactive
if [ $? -ne 0 ]; then
    let "score += 5"
else
  echo "you missed ufw being off" >> /misseditems
  ufw status >> /misseditems
  ufw enable
fi
ufw status verbose | grep Logging | grep -v high
if [ $? -ne 0 ]; then
  let "score += 5"
else
  echo "you missed setting ufw logging to high" >> /misseditems
  ufw status verbose | grep Logging >> /misseditems
  ufw logging high
fi
echo "$score"
