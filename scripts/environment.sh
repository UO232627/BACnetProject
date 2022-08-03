#!/bin/bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt-get install libffi-dev libssl-dev -y
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip

sudo pip install docker-compose

sudo systemctl to enable Docker

docker pull eclipse-mosquitto
cd ./files/docker
docker build ./nodered/dockerfile.dockerfile
docker-compose up
