#!/bin/bash
sudo apt update -y
sudo apt full-upgrade -y

sudo echo "Actualización completada. El sistema se reiniciará en breves segundos..."
sleep 5

sudo systemctl reboot
