#!/bin/bash

PASSWORD="Varun@123"
USER="varun.g"
HOST="10.71.0.10"

echo "[Startup] Launching dc_shell GUI on $USER@$HOST ..."

sshpass -p "$PASSWORD" ssh -X -tt -o StrictHostKeyChecking=no "$USER@$HOST" "exec dc_shell -gui"
