#!/bin/bash

source ./common.sh
app_name=mysql
root_setup

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Installing mysql server"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "Enabling mysql"

systemctl start mysqld 
VALIDATE $? "Starting mysql"

mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "Setting mysql root password"

time_setup