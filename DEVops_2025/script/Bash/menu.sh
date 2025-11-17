
#!/usr/bin/env bash
set -Eeuo pipefail

# === Variables globales ===

BACKUP_DEFAULT_DIR="/backups"
LOG_DIR="/var/log/menu-serveur"
WWW_DIR="/var/www/html"
INOTIFY_LOG="$LOG_DIR/inotify-www.log"


mkdir -p "$LOG_DIR" "$BACKUP_DEFAULT_DIR" "$WWW_DIR"

# Vérifier si inotifywait est installé
if ! command -v inotifywait >/dev/null 2>&1; then
  echo "⚠️  inotifywait n'est pas installé. Installation en cours..."
  apt update -y apt install -y inotify-tools

else
    echo "inotifywait est déja  installer"
fi

pause() {
        read -r -p "Appuie sur Entrée pour continuer..."_
}

disk_usage(){
        echo "Usuage des Disque"
        echo
        df -hT | awk 'NR==1 || ($2 != "tmpfs" && $2 != "devtmpfs") {print $1, $2, $3, $4, $6, $7}'
}

dir_usage(){
        echo " Usage des répertoires "
        echo
        read -rp "Entre le chemin du répertoire à analyser:" directory
        echo "Tu a choisis ce repertoire la  : $directory"
  if  [ -d "$directory" ]; then
        echo "c'est un dossier"
        echo "voici la taille des sous dossier : du -sh "$directory""
        du -sh "$directory"/* 2>/dev/null
else
        echo "ce n'est pas un dossier"
fi
}

backup_dir() {
        echo "Backup d'un répertoire"
        echo
        read -rp "Entre le chemin a sauvegarder :" chemin
        echo "Tu a choisis de sauvegarder : $chemin"
        if [ -d "$chemin" ]; then
                echo "Le chemin existe"
  read -rp "Où veux-tu enregistrer la sauvegarde ? : " destination

   if [ -z "$destination" ]; then
    destination="/backups"
fi
   tar -czf "$destination/backup.tgz" "$chemin"

        else
                echo "le  chemin n'existe pas"
fi


}

cpu_usage() {
        echo " Usage CPU "
        echo

echo " Voici l'utilisation actuelle du CPU : "
top -n 1 | grep "%Cpu" | cut -d "," -f1,2,3,4
}




ram_usage() {
        echo " Usage RAM "
        echo
        echo " Voici l'utilisation de la RAM :"
        free -h | grep 'Mem'

}


check_service(){
        echo " Vérificiation d'un service "
        echo
read -r -p "Quel service veux-tu véfier ? : " service

if systemctl is-active --quiet "$service"; then
        echo "le service est actif"
else
        echo "le service est inactif"

fi

}

IP_ouvert() {
  echo " IPs & ports ouverts "
  echo
  echo " les IPs utilisée sont : "
        hostname -I
  echo " Les ports ouvert sont : "
        ss -tulpen|grep LISTEN
}
monitor_www() {
  echo " Monitoring de /var/www/html "
  echo
  echo " Les modifications seront enregistrées dans : $INOTIFY_LOG"
 inotifywait -m -r -e create,modify,delete "$WWW_DIR" >> "$INOTIFY_LOG"
}

srv_ssh() {
                echo " Configuration SSH "
                echo
read -r -p  "Quel est l'adresse ip du Serveur SSH ? " ip
                echo " l'adresse ip du serveur SSH est $ip "
read -r -p " Sur quel utilisateur souhaitée vous vous connectée ? " user
        echo " Vous souhaitée vous connecter sur :  $user "
read -r -p " Sur quel port ? " port
        if [ -z "$port" ]; then
                port=22
        fi

 echo " vous souhaitez vous connectez via le port suivant : $port "

read -r -p " Quel est le chemin de la  clé privée SSH ? " priv

if  [ -z "$priv" ]; then

        priv="$HOME/.ssh/id_rsa"
fi

echo " tu a choisis ce chemin la : $priv"

 if [ -f "$priv" ]; then
    echo " La clé privée existe déjà."
else
    echo " La clé n'existe pas , génération en cours..."
    ssh-keygen -t rsa -b 4096 -f "$priv" -N ""
fi
public="${priv}.pub"
ssh-copy-id -i "$public" -p "$port" "$user@$ip"

}


menu()  {

        clear
        cat<<EOF

====Menu de Bader Marghadi====

1) Usage des disques
2) Usage des répertoires (chemin demandé)
3) Backup d'un répertoire
4) Usage CPU
5) Usage RAM
6) Vérifier qu'un service fonctionne
7) Lister les ips utilisées sur la machine, et les ports ouverts
8) Affichage des modifications effectuées dans le répertoire /var/www/html
9) Ajouter un serveur SSH
0) Quitter

EOF
}

main() {
        while true; do
        menu
        read -r -p "Ton choix :" c
        case "${c:-}" in
      1) disk_usage; pause;;
      2) dir_usage; pause;;
      3) backup_dir; pause;;
      4) cpu_usage; pause;;
      5) ram_usage; pause;;
      6) check_service; pause;;
      7) IP_ouvert; pause;;
      8) monitor_www; pause;;
      9) srv_ssh; pause;;
      0) echo "Bye."; exit 0;;
      *) echo "Choix invalide."; pause;;
     esac
#!/usr/bin/env bash
set -Eeuo pipefail

# === Variables globales ===

BACKUP_DEFAULT_DIR="/backups"
LOG_DIR="/var/log/menu-serveur"
WWW_DIR="/var/www/html"
INOTIFY_LOG="$LOG_DIR/inotify-www.log"


mkdir -p "$LOG_DIR" "$BACKUP_DEFAULT_DIR" "$WWW_DIR"

# Vérifier si inotifywait est installé
if ! command -v inotifywait >/dev/null 2>&1; then
  echo "⚠️  inotifywait n'est pas installé. Installation en cours..."
  apt update -y apt install -y inotify-tools

else
    echo "inotifywait est déja  installer"
fi

pause() {
        read -r -p "Appuie sur Entrée pour continuer..."_
}

disk_usage(){
        echo "Usuage des Disque"
        echo
        df -hT | awk 'NR==1 || ($2 != "tmpfs" && $2 != "devtmpfs") {print $1, $2, $3, $4, $6, $7}'
}

dir_usage(){
        echo " Usage des répertoires "
        echo
        read -rp "Entre le chemin du répertoire à analyser:" directory
        echo "Tu a choisis ce repertoire la  : $directory"
  if  [ -d "$directory" ]; then
        echo "c'est un dossier"
        echo "voici la taille des sous dossier : du -sh "$directory""
        du -sh "$directory"/* 2>/dev/null
else
        echo "ce n'est pas un dossier"
fi
}

backup_dir() {
        echo "Backup d'un répertoire"
        echo
        read -rp "Entre le chemin a sauvegarder :" chemin
        echo "Tu a choisis de sauvegarder : $chemin"
        if [ -d "$chemin" ]; then
                echo "Le chemin existe"
  read -rp "Où veux-tu enregistrer la sauvegarde ? : " destination

   if [ -z "$destination" ]; then
    destination="/backups"
fi
   tar -czf "$destination/backup.tgz" "$chemin"

        else
                echo "le  chemin n'existe pas"
fi


}

cpu_usage() {
        echo " Usage CPU "
        echo

echo " Voici l'utilisation actuelle du CPU : "
top -n 1 | grep "%Cpu" | cut -d "," -f1,2,3,4
}




ram_usage() {
        echo " Usage RAM "
        echo
        echo " Voici l'utilisation de la RAM :"
        free -h | grep 'Mem'

}


check_service(){
        echo " Vérificiation d'un service "
        echo
read -r -p "Quel service veux-tu véfier ? : " service

if systemctl is-active --quiet "$service"; then
        echo "le service est actif"
else
        echo "le service est inactif"

fi

}

IP_ouvert() {
  echo " IPs & ports ouverts "
  echo
  echo " les IPs utilisée sont : "
        hostname -I
  echo " Les ports ouvert sont : "
        ss -tulpen|grep LISTEN
}
monitor_www() {
  echo " Monitoring de /var/www/html "
  echo
  echo " Les modifications seront enregistrées dans : $INOTIFY_LOG"
 inotifywait -m -r -e create,modify,delete "$WWW_DIR" >> "$INOTIFY_LOG"
}

srv_ssh() {
                echo " Configuration SSH "
                echo
read -r -p  "Quel est l'adresse ip du Serveur SSH ? " ip
                echo " l'adresse ip du serveur SSH est $ip "
read -r -p " Sur quel utilisateur souhaitée vous vous connectée ? " user
        echo " Vous souhaitée vous connecter sur :  $user "
read -r -p " Sur quel port ? " port
        if [ -z "$port" ]; then
                port=22
        fi

 echo " vous souhaitez vous connectez via le port suivant : $port "

read -r -p " Quel est le chemin de la  clé privée SSH ? " priv

if  [ -z "$priv" ]; then

        priv="$HOME/.ssh/id_rsa"
fi

echo " tu a choisis ce chemin la : $priv"

 if [ -f "$priv" ]; then
    echo " La clé privée existe déjà."
else
    echo " La clé n'existe pas , génération en cours..."
    ssh-keygen -t rsa -b 4096 -f "$priv" -N ""
fi
public="${priv}.pub"
ssh-copy-id -i "$public" -p "$port" "$user@$ip"



read -r -p "Quel alias SSH veux tu utiliser ?" alias
        if [ -z "$alias" ]; then
                echo "Aucun alias"
        fi
SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
touch "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"
 
{
  echo ""
  echo "Host $alias"
  echo "  HostName $ip"
  echo "  User $user"
  echo "  Port $port"
  echo "  IdentityFile $priv"
  echo "  Compression yes"
} >> "$CONFIG_FILE"
echo " Alias '$alias' ajouté dans ~/.ssh/config"
}

}


menu()  {

        clear
        cat<<EOF

====Menu de Bader Marghadi====

1) Usage des disques
2) Usage des répertoires (chemin demandé)
3) Backup d'un répertoire
4) Usage CPU
5) Usage RAM
6) Vérifier qu'un service fonctionne
7) Lister les ips utilisées sur la machine, et les ports ouverts
8) Affichage des modifications effectuées dans le répertoire /var/www/html
9) Ajouter un serveur SSH
0) Quitter

EOF
}

main() {
        while true; do
        menu
        read -r -p "Ton choix :" c
        case "${c:-}" in
      1) disk_usage; pause;;
      2) dir_usage; pause;;
      3) backup_dir; pause;;
      4) cpu_usage; pause;;
      5) ram_usage; pause;;
      6) check_service; pause;;
      7) IP_ouvert; pause;;
      8) monitor_www; pause;;
      9) srv_ssh; pause;;
      0) echo "Bye."; exit 0;;
      *) echo "Choix invalide."; pause;;
     esac
    done
}

trap 'echo "Une erreur est survenue. Code $?; exit 1' ERR
main




    done
}

trap 'echo "Une erreur est survenue. Code $?; exit 1' ERR
main




