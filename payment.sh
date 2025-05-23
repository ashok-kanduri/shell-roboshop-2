#!/bin/bash

source ./common.sh
app_name=payment

root_setup
app_setup
python_setup
systemd_setup

time_setup