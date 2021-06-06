#!/bin/bash
# Proxy For Edukasi & Imclass
# ==============================

# Banner / Figlet
echo ""
read -p "Masukan Port Untuk SSH ( NON TLS ) ( DEFAULT = 2082 ) : " portnon
read -p "Masukan Port Untuk SSH ( TLS/SSL ) ( DEFAULT = 2083 ) : " portssl

if [[ $portnon == "" ]]; then
portnon=2082
fi
if [[ $portssl == "" ]]; then
portssl=2083
fi

# Getting Proxy Template
wget -q -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/listio/listio/main/proxy-template.py
chmod +x /usr/local/bin/edu-proxy

# Installing Service
cat > /etc/systemd/system/proxy-nontls.service << END
[Unit]
Description=Python Proxy Mod By WildyProject
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/edu-proxy $portnon
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable proxy-nontls
systemctl restart proxy-nontls

# Installing Service
cat > /etc/systemd/system/proxy-tls.service << END
[Unit]
Description=Python Proxy Mod By WildyProject
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/edu-proxy $portssl
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable proxy-tls
systemctl restart proxy-tls

clear
echo "========================================"
echo "Notes !"
echo "For Restarting Proxy Interface"
echo "Using : systemctl restart proxy-nontls"
echo "Or    : systemctl restart proxy-tls"
echo "========================================"
echo ""
echo "============================"
echo "Non TLS Port : $portnon"
echo "TLS Port     : $portssl"
echo "============================"
echo "Script By WildyProject"