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


yum install -y filebeat
echo "After filebeat install"
echo "here"
rm -f filebeat.yml
wget https://raw.githubusercontent.com/BU-NU-CLOUD-F19/Curating_Log_Files/master/src/filebeat.yml
rm -f automation_journalctl.sh
cat >>automation_journalctl.sh <<EOF
journalctl --since "24 hours ago" -o verbose > /var/log/journal_text.txt
EOF
chmod +x automation_journalctl.sh
service crond restart
if grep "* * * * * /root/automation_journalctl.sh" /var/spool/cron/root; then echo "Entry already in crontab"; else echo "* * * * * /root/automation_journalctl.sh" >>  /var/spool/cron/root; fi
rm -f /etc/filebeat/filebeat.yml
sudo cp filebeat.yml /etc/filebeat/
rm -f filebeat.yml
systemctl enable filebeat
systemctl restart filebeat
