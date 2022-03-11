#!/bin/bash

sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo docker pull 37529445436578/flask-api
sudo docker run -d -p 5000:5000 37529445436578/flask-api