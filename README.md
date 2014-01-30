vFLOWer Toolkit
============================
Created by ByteLife Solutions


1. OVERVIEW

vFLOWer Toolkit along with its pre-requisite components allows vCO administrators and/or developers 
to perform the following actions:

* Retrieve vCO content source code in XML format from remote version control repositories and 
build a binary vCO package to be imported into vCO.
* Publish vCO content source code in XML format to remote version control repositories by 
unpacking/converting exported binary vCO packages. 

NOTE
Current version of this integration tool handles only vCO packages. For publishing, vCO packages 
must be created first including all needed content.


2. PRE-REQUISITES

To work properly vFLOWer Toolkit needs multiple additional publicly available software components:

* Apache Ant. Tested with version 1.9.3. http://ant.apache.org. 
* Oracle Java SE Development Kit. Tested with JDK 1.7.0.45 for Windows.
http://www.oracle.com/technetwork/java/javase/downloads/index.html. 
* OpenSSL. Needed for vCO packages retrieval only. Tested with OpenSSL 1.0.1e for Windows. http://www.openssl.org.
* Git command-line client. Tested with Git 1.8.5.2 for Windows. http://git-scm.com/downloads.
* VMware vCenter Orchestrator client.
* VMware vCenter Orchestrator. Tested with versions 5.1 and 5.5.

NOTES
* This product includes software developed by the Ant-Contrib project
(http://sourceforge.net/projects/ant-contrib).
* When using Windows as a client platform, Git client must be set up with UNIX-style file formats.
vCO is expecting that. 
* On a client machine ANT_HOME and JAVA_HOME environment variables must be set. In addition, 
PATH environment variable must be updated to include ANT, Java, Git client and OpenSSL binary directories. 


3. PUBLISHING vCO CONTENT TO THE GitHub

Multiple manual steps must be performed in order to publish vCO content to GitHub repository. 
All steps can be performed from a client machine having all needed pre-requisite components installed. 

* User account created in GitHub (if not existing). 
* New repository created in GitHub for publishable content. New repository can be created by cloning 
(forking) existing ByteLife’s vFLOWer repository which includes all needed ANT scripts and folder structure. 
* New GitHub repository cloned to the client machine (git clone). 
* A vCO package created using vCO client to include all needed content. 
* The package exported to the client machine into specified input/output directory (part of repository 
folder structure) using vCO client. 
* ByteLife’s ANT precommit script launched from the repository root directory to unpack/convert 
the vCO package into XML-based source code. 
* New content commited and pushed to the remote GitHub repository (git commit, git push). 


4. RETRIEVING vCO CONTENT FROM THE GitHub

Multiple manual steps must be performed in order to retrieve vCO content from public GitHub repository. 
All steps can be performed from a client machine having all needed pre-requisite components installed. 

* vCO content source code downloaded from a public GitHub repository. Content can be downloaded 
by cloning remote repository (git clone) to the client machine which includes all needed ANT scripts 
and folder structure.
* ByteLife’s ANT build script launched from the repository root directory to build a vCO package from 
downloaded XML-based source code.
* The package imported from specified input/output directory to the vCO using vCO client.


==============================================
For more information review vFLOWer_User_Guide.pdf

http://www.bytelife.com/vFLOWer

