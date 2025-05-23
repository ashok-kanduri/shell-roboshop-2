#!/bin/bash

source ./common.sh
app_name=catalogue

root_setup
app_setup
nodejs_setup
systemd_setup

cp $SCRIPT_DIR/mongodb.repo /etc/yum.repos.d/mongodb.repo
dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "Installing mongodb clinet"

STATUS=$(mongosh --host mongodb.kashok.store --eval 'db.getMongo().getDBNames().indexOf("catalogue")')
if [ $STATUS -lt 0 ]
then 
    mongosh --host mongodb.kashok.store </app/db/master-data.js &>>$LOG_FILE
    VALIDATE $? "Loading data into mongodb"
else 
    echo -e "Data is already loaded... $Y SKIPPING $N"
fi

time_setup