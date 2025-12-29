# mediamtx
In mediamtx.yml we need to provide the camera links.


Create a mediamtx.service file under /etc/systemd/system/mediamtx.service
**************************************************************************

[Unit]
Description=MediaMTX RTSP / WebRTC Server
Documentation=https://github.com/bluenviron/mediamtx
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=mediamtx
Group=mediamtx
WorkingDirectory=/opt/mediamtx

ExecStart=/opt/mediamtx/mediamtx /opt/mediamtx/mediamtx.yml

Restart=always
RestartSec=5

# Logging (recommended: journalctl)
StandardOutput=journal
StandardError=journal

# Security hardening (safe defaults)
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=full
ProtectHome=true

[Install]
WantedBy=multi-user.target

Use this below commands to start the mediamtx
*********************************************
sudo systemctl daemon-reload
sudo systemctl enable mediamtx
sudo systemctl start mediamtx

