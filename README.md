## Introduction
This project is mainly used to quickly configure a highly available Hyperledger Fabric network and development environment.

It takes about three months for a novice to start building from the official instance to the final data. If you can quickly use this project, you can undoubtedly grasp it quickly.

This project is mainly divided into these parts:
         1.docker and mirror installation
         
         2.hyperledger development environment installation
         
         3. Fabric network installation with 3 organizations
         
         4. Installation of a smart contract
         
         5. Orderer server high availability architecture

It can help you:
        1. Quickly understand the ibm blockchain project (HyperLedger fabric1.1); Quickly build a highly available version of the architecture.
        
        2. This is a standard online production environment architecture. Of course you have to configure his persistence.
        
        3.HyperLedger compose A set of automated installation and chaining of the framework, each command has been practiced many times.
##  Preface

This sample needs to run on a mutual certificate ssh access basis;

For the entire prerequisite of running this example, please configure host.ini first

When you use this tutorial, you want to first understand the hyperleadger fabric1.1 and be familiar with its rapid development framework, Compose.

In the example, the version we use is compose 0.19.4; fabric1.1; Ansible 2.0.4;

To make a long story short, the example is for a distributed ledger that contains 4 sorting servers, 3 organizations, 2 PEERs per organization, 3 high availability zk and 4 kafka

## Installation
Installation requires 4 virtual machines



| ip | Hostname | Docker startup file | Compose card | Fabric PeerAdmin 
| :---------------------- | :----------------------- | :------------------------------------------------------ | :----------------------- | :-----------------------
| 10.200.156.202   | org1  | org1-kafka.yaml  org1-ord.yaml  org1.yaml  org1-zk.yaml | org1@trade-network | PeerAdmin@byfn-network-org1
| 10.200.156.203   | org2  | org2-kafka.yaml  org2-ord.yaml  org2.yaml  org2-zk.yaml | org2@trade-network | PeerAdmin@byfn-network-org2
| 10.200.156.204   | org3  | org3-kafka.yaml  org3-ord.yaml  org3.yaml  org3-zk.yaml | org3@trade-network | PeerAdmin@byfn-network-org3
| 10.200.156.205   | ext   | ext-kafka.yaml  ext-ord.yaml

### stp1：Org1's environment configuration: the main implementation of install_env.sh /opt/ directory, and then run the start.sh script, this is a must
<pre> cd /opt; sh install_env.sh ;sh start.sh</pre>


### stp2： Org1 can directly access the remaining few virtual machines through the certificate ssh, please be sure to run the following test
<pre> ssh ca.org2.example.com echo "ok";ssh ca.org3.example.com echo "ok";</pre>

### stp3： Install the four machines in the entire sample. The time may take from 10 minutes to 20 minutes
This process is mainly installed docker, NodeJS comose related, of course, there are fabric images

<pre> ansible-playbook /etc/ansible/roles/setup_insenv.yaml</pre>

### stp4： Install hyperledger fabric1.1 network, this is the basis of the entire example
<pre> ansible-playbook /etc/ansible/roles/setup_fabric.yaml</pre>

### stp5：After the fabric network is established, it is necessary to add and upgrade the PEER of each organization.

<pre>ansible-playbook /etc/ansible/roles/setup_network.yaml</pre>

### stp6：Perform compose related steps. This process is very complicated. Finally, if the executed command contains the test of the final result

<pre>ansible-playbook /etc/ansible/roles/setup_compose.yaml</pre>

## File name description

| File name | Description
| :---------------------- | :-----------------------
| compose.sh   | Used to install compose related commands, running account is hyper 
| downimages.sh   | Download hyperledger fabirc compiled image, version 1.1.0, download time according to network speed, may take ten minutes or more
| host.ini   | This is the ip configuration file for the entire network. This needs to replace the old ip according to your existing ip.
| install_env.sh  | Install docker docker-compose nvm and node scripts
| start.sh  | This is the initialization script, which is mainly run on org1 or run on the master control server. It will generate the ansible configuration file and related hosts file; other machines do not need to run it
| *.rpm  | Mainly docker dependent installation package, for centos 7.X, adapted to the intranet environment
|  Org*.yaml  | Mainly for each organization docker-compose startup configuration file contains 2 PEER, 2 tools, 1 certificate
|  org*-kafka.yaml  | Kafka's docker startup configuration file, because it has a sequential startup sequence, so it needs to be independent
|  org*-zk.yaml  | Zookeeper docker startup configuration file
|  org*-ord.yaml  | Sorter server docker configuration file, mainly composed of high availability clusters with zk and kafka
|  npm.yaml  | Nodejs caching service docker startup file
|  generateArtifacts.sh  | Fabric script for generating a certificate private key that defines multiple organization channels and sorting services





## Related operations in this example

 1. https://github.com/hyperledger/composer-knowledge-wiki/blob/latest/knowledge.md

 2.https://hyperledger.github.io/composer/latest/tutorials/deploy-to-fabric-multi-org

 3.http://hyperledger-fabric.readthedocs.io/en/release-1.1/build_network.html

 4.https://github.com/hyperledger/fabric/tree/release-1.1/examples/e2e_cli




