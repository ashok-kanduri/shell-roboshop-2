#!/bin/bash

source ./common.sh
app_name=mongobd

root_setup

cp mongodb.repo /etc/yum.repos.d/mongodb.repo
VALIDATE $? "copying mongodb repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "installing mongodb server"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "enabling mongodb"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "starting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "editing mongodb-conf file for remote connections"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "restarting mongodb"

time_setup

