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

#yum install -y filebeat
echo "After filebeat install"
#ssh -A root@128.31.27.217
scp 128.31.27.217:/etc/pki/tls/certs/logstash.crt /etc/pki/tls/certs/
echo "After certificate copy"
file="/etc/pki/tls/certs/logstash.crt"
echo "before if"
if [ ! -f "$file" ]; then
        echo "$0: File '${file}' not found."
else
        echo "here"
        sudo rm /etc/filebeat/filebeat.yml
        sudo cp filebeat.yml /etc/filebeat/
        systemctl enable filebeat
        systemctl start filebeat
        journalctl --unit filebeat
fi
exit 0
