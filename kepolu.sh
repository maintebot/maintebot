#!/bin/bash
# Proxy For Edukasi & Imclass
# ==============================

# Banner / Figlet
read -p "Press Enter For Contitune : "

# Getting Proxy Template
wget -q -O /usr/local/bin/edu-proxy https://wildyscript.my.id/Edu/proxy-templated.py
chmod +x /usr/local/bin/edu-proxy

# Installing Service
cat > /etc/systemd/system/edu-proxy-nontls.service << END 
[Unit]
Description=Python Edu Proxy
Documentation=https://t.me/nge_gasss
Documentation=https://t.me/nge_gazzz
Documentation=https://t.me/maintebot
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/edu-proxy 2082
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable edu-proxy-nontls
systemctl restart edu-proxy-nontls

# Installing Service
cat > /etc/systemd/system/edu-proxy-tls.service << END 
[Unit]
Description=Python Edu Proxy
Documentation=https://t.me/nge_gasss
Documentation=https://t.me/nge_gazzz
Documentation=https://t.me/maintebot
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/edu-proxy 2083
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable edu-proxy-tls
systemctl restart edu-proxy-tls

clear
rm -f kepolu.sh
echo done

