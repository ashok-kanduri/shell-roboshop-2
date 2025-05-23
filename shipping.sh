#!/bin/bash

source ./common.sh
app_name=shipping

root_setup

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD

app_setup
maven_setup
systemd_setup

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing mysql"

mysql -h mysql.kashok.store -uroot -p$MYSQL_ROOT_PASSWORD -e 'use cities' &>>$LOG_FILE
if [ $? -ne 0 ]
then
    mysql -h mysql.kashok.store -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql &>>$LOG_FILE
    mysql -h mysql.kashok.store -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql &>>$LOG_FILE
    mysql -h mysql.kashok.store -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql &>>$LOG_FILE
else
    echo -e "Data is already loaded into mysql $Y SKIPPING $N"
fi

systemctl restart shipping &>>$LOG_FILE
VALIDATE $? "Restarting shipping"

time_setup