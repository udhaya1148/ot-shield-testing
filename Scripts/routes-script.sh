#!/bin/bash

USERNAME=$(whoami)
SERVICE_FILE="/etc/systemd/system/routes-display.service"

cat <<EOF | sudo tee $SERVICE_FILE
[Unit]
Description=Flask Application with Auto-reload on Changes
After=network.target

[Service]
ExecStart=/usr/bin/python3 /usr/bin/ot-shield-testing/PythonScript/routes.py
Restart=always
User=$USERNAME
WorkingDirectory=/usr/bin/ot-shield-testing/PythonScript
Environment=PYTHONUNBUFFERED=1
Environment=PATH=/usr/bin:/usr/local/bin
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the service
sudo systemctl daemon-reload
sudo systemctl enable routes-display.service
sudo systemctl start routes-display.service
sudo systemctl restart routes-display.service
