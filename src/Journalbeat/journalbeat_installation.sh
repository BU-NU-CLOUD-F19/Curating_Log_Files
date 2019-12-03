#!/bin/bash

cat >>/etc/yum.repos.d/elk.repo<<EOF
[ELK-6.x]
name=ELK repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF


yum install -y journalbeat
echo "Journalbeat installation complete"
rm -f journalbeat.yml
wget https://raw.githubusercontent.com/BU-NU-CLOUD-F19/Curating_Log_Files/master/src/Journalbeat/journalbeat.yml
echo "Getting journalbeat.yml file from server"
rm -f /etc/journalbeat/journalbeat.yml
sudo cp journalbeat.yml /etc/journalbeat/
echo "enabling and restarting journalbeat"
systemctl enable journalbeat
systemctl restart journalbeat
echo "Journalbeat restarted successfully"
