#!/bin/bash
mkdir /home/ubuntu/app
sleep 60
sudo git clone https://github.com/rahul-yadav-hub/MERN-CI-CD-AWS.git /home/ubuntu/app
echo "MONGODB_DEV_URI=${MONGODB_DEV_URI}" > /home/ubuntu/app/.env
echo "PORT=${PORT}" >> /home/ubuntu/app/.env
cd /home/ubuntu/app/; sudo npm install
sudo pm2 start ecosystem.config.js
sudo pm2 save