#!/bin/bash
#update the slack url with one you create
slack_url="https://hooks.slack.com/services/TEJFWAV3L/B01EUMLETJM/Fasdasdasdas"

hostname=$(hostname)
alert_date=$(date)

df -h | grep xvda1 | awk '{ print $5 " " $1 }' | while read output;
do
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge 90 ]; then
   message="Running out of space on $partition on $hostname (jenkins ec2), usage is $usep% as on $alert_date"
   curl -X POST -H 'Content-type: application/json' --data "{
              \"text\": \"$message\"
      }" $slack_url
  fi
done
