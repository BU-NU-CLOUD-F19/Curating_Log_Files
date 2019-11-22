## MOC - Curating Log files Project Proposal

## 1. Vision and Goals Of The Project:

### Vision
Our projects main goal is to capture the system logs generated at MOC, automate the process of collecting logs from different sources and allow users to view them in a central location. 

### Goals
#### Short Term 
* Briefly read the documentation of ElasticSearch and Kibana enough to understand how to install and configure it. We use ElasticSearch and Kibana on OpenShift to see how it is configured and how it is used.
* We plan on deploying 2 VMs on OpenStack
	* VM #1 will have ElasticSearch and Kibana installed on it, and will have a 1T volume used for log storage.
	* VM #2  will be producing logs that will be sent to ElasticSearch via Filebeat.
	* Visualization will be done using Kibana.


#### Long term
* Organize the data so that it is potentially useful for those researchers that have access to the raw data
	* Automate filtering of log files
	

## 2. Users/Personas Of The Project

### End Users:
* Administrators of MOC : Get access to unfiltered/ original logs with confidential information.
* Researchers and Developers: Anonymized logs through which they can analyse how a cloud works, but shouldn’t have access to confidential information about the users of MOC.
* Some researchers and developers will have NDA (non-disclosure agreements) with the MOC so some will be able to gain access to the raw logs.

In the future, we may provide multi-tenant logging so that anyone can access and review all of the           logs  from their projects on the MOC.

## 3. Scope and Features of the Project:

### Features in Current Scope:
* Setting up a collector which is getting log files from the pods on the established VM’s running OpenShift .
* Setting up another virtual machine that acts as a log storage hub in ElasticSearch.
* Automate scaling features:
		* Install ElasticSearch on a virtual machine.
		* Install Filebeat and set up configuration files to forward logs to ElasticSearch. 
		* Set up a cron job to convert Journald logs from binary to text daily on very node.


### Future Scope:
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

1. Sources: (OpenShift Cluster, VMs and Bare metal nodes) - Fluentd pods consisting of multiple containers will collect all the logs pertaining to that pod and store it in a file named fluentd.log.
2. Filebeat: It's a log forwarder that aggregates logs from Fluentd pods and systemd logs, and ships it to Elasticsearch. Alternative: Journalbeat - Works fine, but is a experimental software that can be eradicated in the future.
3. RAW ElasticSearch Master: Index containing all raw log files.
4. Kibana:View the logs.

## 5. Acceptance criteria

The minimum viable product is the demonstration of the specific configuration of services to enable the automated collection of log files. This will include collecting logs from OpenShift nodes sn001-sn005. This will demonstrate how to configure a service that will enable researchers to access logs collected in the short term.

Some stretch goals are:
 1. Anonymizing log files using a ML algorithm

## 6. Release Planning
### Sprint 1 
The first sprint will focus on learning the necessary technical background information needed to proceed with the project, configuring our build environments, and familiarizing ourselves with 
* OpenShift
* OpenStack
* Kibana
* ElasticSearch
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

## 7. Contributors
* Gopalika Sharma
* Paarth Kotak
* Prachi Ved
* Rashi Chauhan




