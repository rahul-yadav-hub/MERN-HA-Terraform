#!/bin/bash
sudo apt update -y
echo 'deb http://repo.pritunl.com/stable/apt focal main' | sudo tee /etc/apt/sources.list.d/pritunl.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
echo 'deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo apt update -y
sudo apt install -y mongodb-server
sudo systemctl start mongodb
sudo apt install pritunl -y
sudo systemctl start pritunl
sudo systemctl enable pritunl mongodb
sudo pritunl set-mongodb mongodb://localhost:27017/pritunl
sudo echo 'Key:' > /home/ubuntu/temp.txt
sudo pritunl setup-key >> /home/ubuntu/temp.txt
sudo pritunl default-password >> /home/ubuntu/temp.txt 2> /dev/null
sudo sed '3d' /home/ubuntu/temp.txt > /home/ubuntu/pritunlCreds.txt
sudo rm temp.txt