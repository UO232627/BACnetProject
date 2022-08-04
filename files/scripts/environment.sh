#!/bin/bash
sudo apt install -y git

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt-get install -y libffi-dev libssl-dev
sudo apt install -y python3-dev
sudo apt-get install -y python3 python3-pip

sudo pip3 install docker-compose

sudo systemctl to enable Docker

docker pull eclipse-mosquitto
cd ./files/docker
docker build ./nodered/dockerfile.dockerfile
docker-compose up