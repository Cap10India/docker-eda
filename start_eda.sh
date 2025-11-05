#!/bin/bash

PASSWORD="Varun@123"
USER="varun.g"
HOST="10.71.0.10"

echo "[Startup] Auto SSH login to $USER@$HOST..."

sshpass -p "$PASSWORD" ssh -X -t -t -o StrictHostKeyChecking=no "$USER@$HOST" "dc_shell -gui"\
'csh -c "source ~/.cshrc; exec csh"'
