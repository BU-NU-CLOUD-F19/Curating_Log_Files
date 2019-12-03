#!/bin/bash

yum install -y java-1.8.0-openjdk
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

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

yum install -y elasticsearch
yum install -y wget
rm -f elasticsearch.yml
wget https://raw.githubusercontent.com/BU-NU-CLOUD-F19/Curating_Log_Files/master/src/elasticsearch.yml
rm -f /etc/elasticsearch/elasticsearch.yml
sudo cp elasticsearch.yml /etc/elasticsearch/
systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch

yum install -y kibana
rm -f kibana.yml
wget https://raw.githubusercontent.com/BU-NU-CLOUD-F19/Curating_Log_Files/master/src/kibana.yml
rm -f /etc/kibana/kibana.yml
sudo cp kibana.yml /etc/kibana/
systemctl enable kibana
systemctl start kibana
if [ $? -ne 0 ]; then
        echo "Could not start kibana and set kibana to start automatically when the system boots. (Error Code: $ERROR)."
else
        echo "Kibana installed successfully."
fi