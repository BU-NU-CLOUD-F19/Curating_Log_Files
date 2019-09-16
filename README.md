## MOC - Curating Log files Project Proposal

## 1. Vision and Goals Of The Project:

### Vision
To build a system which will start to capture the system logs generated at MOC, automate the process of anonymizing logs and organize logs by some a methodology which will help to see if there is a pattern such as demands on different services and how they are correlated.

### Goals
* Fetch the log files from different services running on MOC.
* Automating the filter process of log data, obfuscating any PII.
* Organize the anonymizing data to draw meaningful insights.

## 2. Users/Personas Of The Project

### End Users:
* Administrators of MOC
* Users who would like to know MOC usage statistics.

### It does not target:
* Administrators of cloud services, who will continue to use existing tools like Horizon.
* Advanced users with complex requirements who are expected to use command line interfaces.

## 3. Scope and Features of the Project:

### Features in Current Scope:
* Getting logs from various services on MOC.
* Modify the current services to start capturing system logs.
* Deploying Elastic Search with Kibana to search through logs
* Try to analyze log files to provide a feasible algorithm which identifies features and extract PII data.
* Filter the logs on PII

### Future Scope:
* Organize anonymizing logs in a way from which we can build ML models to determine if there are patterns of correlation.

## 4. Solution Concept

Automate the process of filtering log files for PII using a suitable algorithm which can be used to filter multiple log files across different systems.


![Overview](https://github.com/BU-NU-CLOUD-F19/Curating_Log_Files/blob/master/images/FCC.png)


### Component Description:

1. Sources: Sources (Data stores) on the MOC from where the log files would be taken as an input.
2. Log file Fetch Service: Script/Service that fetches data from different MOC cloud sources and sends the log files to an Object File Storage service.
3. Log file Storage: An object-based storage mechanism that can be used to store original as well as the filtered log files.
4. Function to filter files: A script that detects anomalies/PII information in the log files, removes the confidential information and passes it onto another block storage for further analyzing/visualization.
5. Elasticsearch Service: A search tool used to provide relevant files to users.
6. End User: Researchers who want to analyze the log file data and gain insights into the MOC system.

## 5. Acceptance criteria

Provide a service which enables users to access anonymized log files from some services from MOC.

Some stretch goals are:
 1. Creating an algorithm which can work with multiple data sources.
 2. Using ML algorithms to detect anomalies in the log files.



