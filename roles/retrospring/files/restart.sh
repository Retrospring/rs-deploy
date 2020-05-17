#!/bin/sh
# restart.sh -- restarts one of the two justask web instances
#
# This file is managed by Ansible.  Changes made here will be lost.

systemctl is-active justask-web@01 --quiet
w01_active=$?
systemctl is-active justask-web@02 --quiet
w02_active=$?

if [ $w01_active -eq 0 ]; then
  current_active=01
  to_active=02
elif [ $w02_active -eq 0 ]; then
  current_active=02
  to_active=01
else
  echo "Wow, no server is active.  We should better start one!"
  echo ""
  current_active=""
  to_active=01
fi

echo "Active server: ${current_active:-none}"

echo "Starting justask-web@${to_active}"
systemctl start "justask-web@${to_active}"

echo -n "Waiting for justask-web@${to_active} to finish starting up... (max 60s)"
counter=60
while ! curl --unix-socket "/var/run/justask-web-${to_active}/puma.sock" http://localhost/ -s > /dev/null; do
  if [ $counter -eq 0 ]; then
    echo " Timeout"
    echo "Try it again"
    exit 1
  fi
  counter=$(( $counter - 1 ))
  echo -n "."
  sleep 1
done
echo

if [ -n "$current_active" ]; then
  echo "Taking down ${current_active}"
  systemctl stop "justask-web@${current_active}"
fi

echo "All good!"
