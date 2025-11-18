#!/bin/bash
set -e

# Mise à jour des paquets
apt update

# Installer Apache2
apt install -y apache2

# Installer PHP + CLI + module Apache
apt install -y php php-cli libapache2-mod-php

# Active Apache au démarrage et démarre le service
systemctl enable apache2
systemctl restart apache2



# Création d'une page html
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>TP Vagrant LAMP</title>
</head>
<body>
    <h1>Bienvenue sur le serveur LAMP de Bader</h1>
    <p>Apache + PHP installés automatiquement.</p>
</body>
</html>
EOF

# Message MOTD
echo "VM TP – LAMP Server" > /etc/motd



