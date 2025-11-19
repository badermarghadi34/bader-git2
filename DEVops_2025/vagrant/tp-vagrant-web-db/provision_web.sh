#!/bin/bash
set -e

apt update

# Installation Apache
apt install -y apache2

# Installation PHP 
apt install -y php php-mysql

# Activer Apache au démarrage
systemctl enable apache2
systemctl restart apache2









