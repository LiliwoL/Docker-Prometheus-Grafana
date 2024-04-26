# Installation des paquets nécessaires
apt update && apt install wget curl

# Récupération de la dernière version du apache exporter
curl -s https://api.github.com/repos/Lusitaniae/apache_exporter/releases/latest|grep browser_download_url|grep linux-amd64|cut -d '"' -f 4|wget -qi -

# Décompression
tar xvf apache_exporter-*.linux-amd64.tar.gz

# Copie du binaire dans le dossier /usr/local/bin
cp apache_exporter-*.linux-amd64/apache_exporter /usr/local/bin

chmod +x /usr/local/bin/apache_exporter

# Création de l'utilisateur et du groupe prometheus
groupadd --system prometheus
useradd -s /sbin/nologin --system -g prometheus prometheus

# Lancement de apache_exporter
apache_exporter --insecure --scrape_uri=http://localhost/server-status/?auto &
