# Installation instructions for CentOS

### Clone

- Clone this repo to your local machine using `https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files.git`

## Assumptions
es.master.com __(Elasticsearch master)__

log.client.com __(client machine)__

## Elasticsearch-Kibana Stack installation on es.master.com
###### Give elasticsearch_automation.sh script executable permissions:
###### cd into the /src/Elastic+Kibana directory of the cloned repository and execute:
```
chmod +x elasticsearch_automation.sh
```
###### Run the installation script(make sure you are the root user and no multiple instances of Kibana are present on different users in the same host)
```
./elasticsearch_automation.sh
```
Elasticsearch will now be available through port 9200 and Kibana will be running on port 5601 on es.master.com

## Journalbeat installation on log.client.com
###### Give journalbeat_installation.sh script executable permissions:
###### cd into the /src/JournalBeat directory of the cloned repository and execute:
```
chmod +x journalbeat_installation.sh
```
##### Run the installation script
```
./journalbeat_installation.sh
```
##### Configure journalbeat on log.client.com to send logs to Elasticsearch on es.master.com.
1. cd into /etc/journalbeat directory on your machine
2. Modify journalbeat.yml by going to the Output section of the file and replacing the hosts section in output.elasticsearch to:
```
es.master.com:9200
```
The elasticsearch output section of journalbeat.yml file should look like the following:

![JournalbeatConfig](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/images/JournalbeatConfig.png)

Journalbeat is now installed on the client machines to collect logs and send to elasticsearch on es.master.com

Currently it is configured to send files to http://logging.osh.massopen.cloud:9200 which is the host on which elasticsearch is running.

## Filebeat installation on log.client.com
This is an alternate to Journalbeat and is not required to be installed. Since Journalbeat is experimental we have given an alternative to it.
###### Give automation.sh script executable permissions:
###### cd into the /src/Filebeat directory of the cloned repository and execute:
```
chmod +x automation.sh
```
##### Run the installation script
```
./automation.sh
```
##### Configure Filebeat on log.client.com to send logs to Elasticsearch on es.master.com.
1. cd into /etc/filebeat directory on your machine
2. Modify filebeat.yml by going to the Output section of the file and replacing the hosts section in output.elasticsearch to:
```
es.master.com:9200
```
The elasticsearch output section of filebeat.yml file should look like the following:

![FilebeatConfig](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/images/FilebeatConfig.png)

Filebeat is now installed on the client machines to collect logs and send to elasticsearch on es.master.com

Currently it is configured to send files to http://logging.osh.massopen.cloud:9200 which is the host on which elasticsearch is running.

