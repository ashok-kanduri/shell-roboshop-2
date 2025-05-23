#!/bin/bash

source ./common.sh
app_name=redis
root_setup

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disabling default redis"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enabling redis:7"

dnf install redis -y &>>$LOG_FILE
VALIDATE $? "installing redis:7"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "editing redis.conf to accept remote connections"

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "enabling redis"

systemctl start redis &>>$LOG_FILE
VALIDATE $? "starting redis"

time_setup