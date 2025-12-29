# mediamtx
In mediamtx.yml we need to provide the camera links.

paths:
  camera1:
    source: publisher
    #source: rtsp://admin:administrator@192.168.0.101:554/ch0_0.264
    #sourceOnDemand: yes
    runOnDemand: ffmpeg -fflags nobuffer -flags low_delay -i rtsp://admin:administrator@192.168.0.101:554/ch0_0.264 -r 5 -c:v libx264 -preset ultrafast -tune zerolatency -profile:v baseline -level 3.1 -pix_fmt yuv420p -g 10 -keyint_min 10 -sc_threshold 0 -bufsize 256k -maxrate 500k -c:a aac -ar 44100 -b:a 64k -f rtsp -rtsp_transport tcp rtsp://127.0.0.1:8554/$MTX_PATH
    runOnDemandRestart: yes

  camera2:
    source: publisher
    #source: rtsp://admin:administrator@192.168.0.102:554/ch0_0.264
    #sourceOnDemand: yes
    runOnDemand: ffmpeg -fflags nobuffer -flags low_delay -i rtsp://admin:administrator@192.168.0.102:554/ch0_0.264 -r 5 -c:v libx264 -preset ultrafast -tune zerolatency -profile:v baseline -level 3.1 -pix_fmt yuv420p -g 10 -keyint_min 10 -sc_threshold 0 -bufsize 256k -maxrate 500k -c:a aac -ar 44100 -b:a 64k -f rtsp -rtsp_transport tcp rtsp://127.0.0.1:8554/$MTX_PATH
    runOnDemandRestart: yes


    
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

