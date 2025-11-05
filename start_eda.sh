#!/bin/bash

PASSWORD="Varun@123"
USER="varun.g"
HOST="10.71.0.10"

echo "[Startup] Auto SSH login to $USER@$HOST..."

sshpass -p "$PASSWORD" ssh -X "dc_shell -gui" -t -t -o StrictHostKeyChecking=no "$USER@$HOST" 

