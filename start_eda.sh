#!/bin/bash

PASSWORD="Varun@123"
USER="varun.g"
HOST="10.71.0.10"

echo "[Startup] Auto SSH login to $USER@$HOST..."

sshpass -p "$PASSWORD" ssh -X -t -t -o StrictHostKeyChecking=no "$USER@$HOST" \
'csh -c "source ~/.cshrc; dc_shell -gui; exec csh"'

