## MOC - Curating Log files Project Proposal

## 1. Vision and Goals Of The Project:

Our projects main goal is to capture the system logs generated at ([MOC](link:https://massopen.cloud/)), automate the process of collecting logs from different sources and allow users to view them in a central location. Organize the data so that it is potentially useful for those researchers that have access to the raw data.

Main Goals of the Project:

* Provide an automated mechanism to collect logs from different source machines on MOC. 
* Have a log collector deployed on each source that reads systemd logs and forwards them to elasticsearch deployed on a destination machine where all the logs from different sources are collected and converged.
* Provide visualization of the logs in Elasticsearch through Kibana.

Some stretch goals are:
* Get data out of Elasticsearch in order to be able to share it
	
## 2. Users/Personas Of The Project

### End Users:
* Administrators of MOC : Get access to unfiltered/ original logs with confidential information.
* Researchers and Developers: Logs provided through which they can analyse how a cloud works, but shouldn’t have access to confidential information about the users of MOC (Some filter mechanism will be required which can be implemented as a future scope).
* Some researchers and developers will have NDA (non-disclosure agreements) with the MOC so some will be able to gain access to the raw logs in Elasticsearch.

## 3. Scope and Features of the Project:

### Features in Current Scope:
* Setting up a collector which is getting log files from the pods on the established VM’s running OpenShift .
* Setting up a virtual machine that acts as a log storage hub in ElasticSearch.
* Automate scaling features:
	* Provide an installation script for installing and configuring Journalbeat to run on the host machine, collect system logs and send them to the machine on which Elasticsearch is running.
	* Provide an installation script to configure Elasticsearch and Kibana with the logs viewable at [Kibana Dashboard](logging.osh.massopen.cloud:5602)
	* Get the pipeline up and running to collect logs from OpenShift nodes sn001 to sn005 and send to the Elasticsearch virtual machine deployed on OpenStack.

### Future Scope:

* Automate filtering of log files
* Incorporating additional log sources, e.g. ceph etc
* A filter to detect and potentially obfuscate any PII
    * We are considering various test ways of filtering the log data; for example:
		* Clustering: We can cluster the log files with respect to a keyword related to the PII we are trying to obfuscate. It is easier to filter the files when they are in clusters.
        * Deep Learning: The feature maps of a CNN (filters in Deep learning model) capture the result of applying the filters to an input image, where the feature maps here mean identifying our log files with a user defined key.
        * KNN item based collaborative filtering:KNN is a non-parametric, lazy learning method. It uses a database in which the data points are separated into several clusters to make inference for new samples.KNN does not make any assumptions on the underlying data distribution but it relies on item feature similarity. we need to configure our KNN model with proper hyper-params.
        * Algorithm used for Biogenesis: We can try to use this algorithm to find a difference in the pattern of the log files so that we can segregate them, like it is done for DNA sequencing.
	* General testing for these methods on example log files (which contain known mock PII )
       and evaluate:
    	* percentage that was found etcetera.
	* Organize the anonymizing data to draw meaningful insights like get performance of various components in MOC cloud on which they can run simulations on.


## 4. Solution Concept

![Overview](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/images/FCC.png)


### Component Description:

1. Sources: OpenShift Cluster nodes that we collect logs from. Can be extended to collect logs from VMs and Bare metal nodes.
2. Journalbeat: A lightweight shipper for forwarding and centralizing log data from systemd journals. Installed as an agent on your servers, Journalbeat monitors the journal locations that you specify, collects log events, and forwards them to Elasticsearch. Journalbeat is an Elastic Beat. It’s based on the libbeat framework.
3. RAW ElasticSearch Master: Indexes created daily containing all raw log files with field entries like system information, log messages and few more key additional details.
4. Kibana: A Kibana Dashboard hosted on an external url [Kibana Dashboard](logging.osh.massopen.cloud:5602) to view indexes and filter logs.

## 5. Acceptance criteria

The minimum viable product is the demonstration of the specific configuration of services to enable the automated collection of log files and providing them to the user in a suitable form. This will include collecting logs from OpenShift nodes sn001-sn005.This will demonstrate how to configure a service that will enable researchers to access logs collected in the short term.

## 6. Release Planning
### Sprint 1 
The first sprint will focus on learning the necessary technical background information needed to proceed with the project, configuring our build environments, and familiarizing ourselves with 
* OpenShift
* OpenStack
* Kibana
* ElasticSearch
* Filebeat
* Journalbeat
* Logstash
* MOC log collection sources. 
* Create Story Cards.(Taiga)

Technical spike: 
* Begin progress towards first milestone by setting up VM on openshift where we plan to identify log sources from multiple VMs running s-openshift.

[Demo link](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/demos/Week1.pptx)


### Sprint 2
In Sprint 2, we’d like to move close to completion on our first milestone and begin work on our second. Particularly, we’d like to finish the following features:
* Fetching all log files from multiple fluentd pods, which are on multiple VM’s running openshift.
* Set up ElasticSearch and Kibana for searching raw log files on one VM.

[Demo link](https://docs.google.com/presentation/d/1Lb6w3OOkxOWkB-IKia2YSLu2TSyXegyiNVqggS_0JC0/edit?usp=sharing)


### Sprint 3
We’d like to reach the first milestone towards our minimum acceptance criteria in Sprint 3:
* We plan to get an idea about what PII needs to be eliminated from the log files and start implementing it on the collected log files.

[Demo link](https://1drv.ms/p/s!AkxTmCI5bOduolw-_DrHA8nTTuFw)

### Sprint 4
In Sprint 4, we aim to complete the minimum acceptance criteria for the project. 
* We plan to get the pipeline that gets the logs into Elasticsearch working.

[Demo link](https://docs.google.com/presentation/d/1SH1uk2c1wEw1WvuMuofFlmsqSqIh6njIhA0qGZ1hxU4/edit?usp=sharing)

### Sprint 5
This sprint is dedicated to the completion of additional enhancements and scaling features. Specifically, these goals include:
* Mitigating the possibility of duplicate logs being sent to elasticsearch.
* Automated scripts to facilitate collecting logs from sn001, sn002, sn003, and sn005 - sn004(Bastian node).
* Automated script to install ElasticSearch and Java on the centralized log collecting node. 
* Experiement with JournalBeat as a replacement to Filebeat.

[Demo link](https://docs.google.com/presentation/d/18rMIOXpnfeDlslEvj1_XluwOT4YEgfpM75S5_-QNLAw/edit?usp=sharing)

### Final presentation and Video

[Presentation](https://prezi.com/view/HJTMrKolB6Vddy8UkSXG/)
[Video](https://youtu.be/1XmLbdqIEmM)


## 7. Setup

[Installation Instructions](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/Install.md)

## 8. Contributors
* Gopalika Sharma
* Paarth Kotak
* Prachi Ved
* Rashi Chauhan




