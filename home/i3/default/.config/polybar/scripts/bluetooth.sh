#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{T2}󰂲"
else
  echo "%{T2}󰂯"
fi
