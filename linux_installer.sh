#!/bin/bash

# ==========================================
# GURU ADMIN - LINUX AUTO INSTALLER (CLI)
# ==========================================
# Run with: sudo bash linux_installer.sh

# Konfigurasi
APP_DIR="/opt/Guru-admin"
SERVICE_NAME="guruadmin"
USER_NAME=$SUDO_USER
if [ -z "$USER_NAME" ]; then
    USER_NAME=$(whoami)
fi

# Visual Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=============================================${NC}"
echo -e "${GREEN}   GURU ADMIN CLI INSTALLER v1.6.4           ${NC}"
echo -e "${GREEN}=============================================${NC}"

# 1. Cek Root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: Script ini harus dijalankan sebagai root (sudo).${NC}" 
   exit 1
fi

# 2. Update System & Install Dependencies
echo -e "\n[1/5] Menginstall System Dependencies..."
apt-get update -qq
apt-get install -y python3 python3-pip python3-venv unzip curl -qq

# 3. Setup Folder
echo -e "\n[2/5] Menyiapkan Folder Aplikasi di ${APP_DIR}..."
if [ -d "$APP_DIR" ]; then
    echo "      Folder sudah ada, melakukan backup..."
    mv "$APP_DIR" "${APP_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
fi
mkdir -p "$APP_DIR"
chown $USER_NAME:$USER_NAME "$APP_DIR"

# 4. Download Source Code
DOWNLOAD_URL="https://github.com/bijuri/administrasi-guru/releases/download/v1.6.4/Linux_Protected_Install_v1.6.4.zip" 

if [ -z "$DOWNLOAD_URL" ]; then
    # Jika URL kosong, minta user input file lokal atau URL
    echo -e "${RED}URL Download belum diset di script.${NC}"
    echo "Silakan letakkan file .zip installer di folder ini, lalu ketik namanya."
    read -p "Nama file zip (contoh: install.zip): " ZIP_FILE
    
    if [ ! -f "$ZIP_FILE" ]; then
        echo -e "${RED}File tidak ditemukan!${NC}"
        exit 1
    fi
    echo "Mengextract $ZIP_FILE..."
    unzip -o "$ZIP_FILE" -d "$APP_DIR" > /dev/null
else
    echo -e "\n[3/5] Mendownload Aplikasi..."
    echo "URL: $DOWNLOAD_URL"
    curl -L "$DOWNLOAD_URL" -o temp_install.zip
    unzip -o temp_install.zip -d "$APP_DIR" > /dev/null
    rm temp_install.zip
fi

# 5. Setup Python Environment
echo -e "\n[4/5] Setup Python Environment..."
cd "$APP_DIR"
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt --quiet --disable-pip-version-check
echo "Dependencies Python terinstall."

# 6. Setup Permission
chown -R $USER_NAME:$USER_NAME "$APP_DIR"

# 7. Setup Systemd Service
echo -e "\n[5/5] Setup Auto-Start Service..."
cat > /etc/systemd/system/${SERVICE_NAME}.service << EOF
[Unit]
Description=Guru Admin Web Service
After=network.target

[Service]
User=$USER_NAME
Group=$USER_NAME
WorkingDirectory=$APP_DIR
Environment="PATH=$APP_DIR/venv/bin"
ExecStart=$APP_DIR/venv/bin/gunicorn --workers 4 --bind 0.0.0.0:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ${SERVICE_NAME}
systemctl restart ${SERVICE_NAME}

# Final Check
if systemctl is-active --quiet ${SERVICE_NAME}; then
    IP_ADDR=$(hostname -I | cut -d' ' -f1)
    echo -e "\n${GREEN}✅ INSTALASI SUKSES!${NC}"
    echo -e "Akses aplikasi di: http://$IP_ADDR:8000"
    echo -e "Login Default: admin / admin123"
else
    echo -e "\n${RED}⚠️ Service gagal start. Cek logs dengan: journalctl -u ${SERVICE_NAME}${NC}"
fi
