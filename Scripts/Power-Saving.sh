#!/bin/bash

figlet "Power Saving:"
echo "1. Screen Blank"
echo "2. Suspend"
echo "3. Show current values"
echo "4. Activate All"

read saver

if [[ $saver -eq 1 ]]; then
  echo "1. NEVER"
  echo "2. Timer"
  
  read dim
  
  if [[ $dim -eq 1 ]]; then
    gsettings set org.gnome.desktop.session idle-delay 0
    echo "Screen Dim set to never"
    
  elif [[ $dim -eq 2 ]]; then
    echo "Enter the minutes Dim screen after:"
    read time
    time=$((time * 60))  # Convert minutes to seconds
    gsettings set org.gnome.desktop.session idle-delay $time
    echo "Dim time set to $time seconds"
  fi

elif [[ $saver -eq 2 ]]; then
  echo "1. On Battery"
  echo "2. On Charging"
  
  read sus

  if [[ $sus -eq 1 ]]; then
    # Toggling the sleep-inactive-battery-type setting
    current_value=$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type)
    if [[ $current_value == "'nothing'" ]]; then
      gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
      echo "Sleep on battery set to suspend."
    else
      gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
      echo "Sleep on battery set to nothing."
    fi
  elif [[ $sus -eq 2 ]]; then
    # Toggling the sleep-inactive-ac-type setting
    current_value=$(gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type)
    if [[ $current_value == "'nothing'" ]]; then
      gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
      echo "Sleep on charging set to suspend."
    else
      gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
      echo "Sleep on charging set to nothing."
    fi
  fi

elif [[ $saver -eq 3 ]]; then
  echo "For Battery:"
  gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
  echo "For charging:"
  gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
  echo "Is Sleeping:"
  gsettings get org.gnome.desktop.session idle-delay 

elif [[ $saver -eq 4 ]]; then
  echo activating All ......In Work

fi

#Other Commands

#To set delay
#gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac/battery-timeout <timeout> 
