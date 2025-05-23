#!/bin/bash

source ./common.sh
app_name=rabbitmq

root_setup

echo "Please enter root password to setup"
read -s RABBITMQ_PASSWORD

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo 
VALIDATE $? "Copying rabbitmq repo"

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "Installing rabbitmq server"

systemctl enable rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Enabling rabbitmq server"

systemctl start rabbitmq-server
VALIDATE $? "Starting rabbitmq server"

rabbitmqctl add_user roboshop $RABBITMQ_PASSWORD &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE

time_setup