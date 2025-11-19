#!/bin/bash
set -e

# Mise à jour des paquets
apt update

# Installer Apache2
apt install -y apache2

# Installer PHP 
apt install -y php php-cli libapache2-mod-php

# Active Apache au démarrage et démarre le service
systemctl enable apache2
systemctl restart apache2



# Message MOTD
echo "VM TP – LAMP Server" > /etc/motd


