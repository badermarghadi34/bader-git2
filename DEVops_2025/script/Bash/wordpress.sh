#!/bin/bash

#Installer LAMP   
apt update -y &&  apt install -y apache2 mariadb-server php libapache2-mod-php php-mysql php-xml php-curl php-zip php-gd php-mbstring unzip wget curl

#Installer wordpress
apt update && apt upgrade -y  
cd /tmp
wget https://wordpress.org/latest.zip
unzip -q latest.zip  
cp -r /tmp/wordpress/* /var/www/html/
chown -R www-data:www-data /var/www/html/


# Création de la base données  
DB_USER="root"
DB_PASS="Bader2004."
DB_NAME="wordpress"

mysql -u"$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Création d’un utilisateur et attribution des droits
mysql -u"$DB_USER" -p"$DB_PASS" -e "
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;
"

#INSTALLATION DE FAIL2BAN
apt-get install -y fail2ban
mkdir -p /etc/fail2ban/jail.d
cat > /etc/fail2ban/jail.d/apache-wp-login.conf <<'EOF'
[apache-wp-login]
enabled  = true
port     = http,https
filter   = apache-wp-login
logpath  = /var/log/apache2/access.log
maxretry = 3
findtime = 36
bantime  = 36
EOF
cat > /etc/fail2ban/filter.d/apache-wp-login.conf <<'EOF'
[Definition]
failregex = ^<HOST> -.*POST /wp-login\.php HTTP.*
EOF
# 5) Tester la conf puis démarrer
fail2ban-server -t
systemctl start fail2ban
# 6) Vérifs
systemctl status fail2ban --no-pager
fail2ban-client status
fail2ban-client status apache-wp-login || true
