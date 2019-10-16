## MOC - Curating Log files Project Proposal

## 1. Vision and Goals Of The Project:
### Vision
To build a system which will start to capture the system logs generated at MOC, automate the process of anonymizing logs and organize logs by a methodology which will help to see if there is a pattern such as demands on different services and how they are correlated.

### Goals
#### Short Term
* Briefly read the documentation of ElasticSearch and Kibana enough to understand how to install and configure it. We use ElasticSearch and Kibana on OpenShift to see how it is configured and how it is used.
* We plan on deploying 2 VMs on OpenStack
	* VM #1 will have ElasticSearch and Kibana installed on it, and will have a 1T volume used for log storage.
 	* VM #2  will be producing logs that will be collected by ElasticSearch.
 	* Visualization will be done using Kibana.

#### Long term
* Organize the data so that it is potentially useful for those researchers that have access to the raw data
 	* Automate filtering of log files
 	* One such filter is to detect and potentially obfuscate any PII
    * We are considering various test ways of filtering the log data; for example:
  		* Clustering: We can cluster the log files with respect to a keyword related to the PII we are trying to obfuscate. It is easier to filter the files when they are in clusters.
    	* Deep Learning: The feature maps of a CNN (filters in Deep learning model) capture the result of applying the filters to an input image, where the feature maps here mean identifying our log files with a user defined key.
    	* KNN item based collaborative filtering:KNN is a non-parametric, lazy learning method. It uses a database in which the data points are separated into several clusters to make inference for new samples.KNN does not make any assumptions on the underlying data distribution but it relies on item feature similarity. we need to configure our KNN model with proper hyper-params.
    	* Algorithm used for Biogenesis: We can try to use this algorithm to find a difference in the pattern of the log files so that we can segregate them, like it is done for DNA sequencing.
 	* General testing for these methods on example log files (which contain known mock PII )
   	and evaluate:
	* percentage that was found etcetera.
 	* Organize the anonymizing data to draw meaningful insights like get performance of various components in MOC cloud on which they can run simulations on.
	
## 2. Users/Personas Of The Project

### End Users:
* Administrators of MOC : Get access to unfiltered/ original logs with confidential information.
* Researchers and Developers: Anonymized logs through which they can analyse how a cloud works, but shouldn’t have access to confidential information about the users of MOC.
* Some researchers and developers will have NDA (non-disclosure agreements) with the MOC so some will be able to gain access to the raw logs.

In the future, we may provide multi-tenant logging so that anyone can access and review all of the       	logs  from their projects on the MOC.

## 3. Scope and Features of the Project:

### Features in Current Scope:
* Configure ELK (ElasticSearch, Logstash, Kibana) Stack.
* Configure Filebeat on all sources to collect logs from var/log/fluentd (fluentd.log) and send them to Logstash on the virtual machine. 
* Setting up a mapping in Logstash to output the logs collected in elastic search with basic search fields.
* Installing Kibana on VM1 to interact with ElasticSearch and visualize on the kibana console.
* Scale the process using an automated script to run on multiple servers and collect logs on a wider level.
* Deploy a second virtual machine on OpenStack and install Kibana and ElasticSearch on it to interact with the first vm to filter and display the filtered logs.

### Future Scope:
* Organize anonymizing logs in a way from which we can build ML models to determine if there are patterns of correlation between different log files.
* Have a testing mechanism or using one of the above mentioned ML algorithms in place to validate if the log collection process works as expected.

## 4. Solution Concept

![Overview](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/images/FCC.png)


### Component Description:
1. Sources: (OpenShift Cluster, VMs and Bare metal nodes) - Fluentd pods consisting of multiple containers will collect all the logs pertaining to that pod and store it in a file named fluentd.log in the /var/log/fluentd directory.
2. Filebeat: Logging agent that collects logs from /var/log/fluent directory and passes them onto Logstash on the VM1 to push them to ElasticSearch index.
3. Logstash: OpenSource tool used for converging log files given by filebeat on multiple sources in one place, transform them into one specific format, and output it to ElasticSearch index on VM1.
3. RAW ElasticSearch Master: Index containing all raw log files forwarded from Logstash.
4. Filter Script:  Filter function will use the logstash config to identify PII, remove them.
5. Filtered Elastic Search Master: Index containing all curated log files.
6. Kibana:View the logs.

## 5. Acceptance criteria

The minimum viable product is the demonstration of the specific configuration of services to enable the automated collection of log files. This will include collecting logs from a separate OpenStack VM and collecting logs from staging openshift. This will demonstrate how to configure a service that will enable researchers to access logs collected in the short term.

Some stretch goals are:
 1. Creating an algorithm which can work with multiple data sources.
 2. Using ML algorithms to detect anomalies in the log files.
 
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

### Sprint 4
In Sprint 4, we aim to complete the minimum acceptance criteria for the project.
* We plan to collect our filtered logs on to the new elastic search master instance.

### Sprint 5
This sprint is dedicated to the completion of any goals that weren’t completed on time in previous sprints, and reaching stretch goals. Specifically, these goals include:
* Creating an algorithm which can work with multiple data sources.
* Using ML algorithms to detect anomalies in the log files.
## 7. Contributors

* Gopalika Sharma
* Paarth Kotak
* Prachi Ved
* Rashi Chauhan



