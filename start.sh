#!/bin/bash
#Get related IP
org1_ip=`cat host.ini |grep org1|awk -F '=' '{print $2}'`
org2_ip=`cat host.ini |grep org2|awk -F '=' '{print $2}'`
org3_ip=`cat host.ini |grep org3|awk -F '=' '{print $2}'`
ext_ip=`cat host.ini |grep ext|awk -F '=' '{print $2}'`
#Change the test IP into the actual environment IP
sed -i "s/10.206.9.39/$org1_ip/g" file/fabric1.1/*.yaml file/fabric1.1/ansible/hosts file/fabric1.1/hosts file/fabric1.1/npmConfig.txt
sed -i "s/10.206.9.36/$org2_ip/g" file/fabric1.1/*.yaml file/fabric1.1/ansible/hosts file/fabric1.1/hosts
sed -i "s/10.206.9.37/$org3_ip/g" file/fabric1.1/*.yaml file/fabric1.1/ansible/hosts file/fabric1.1/hosts
sed -i "s/10.206.9.55/$ext_ip/g" file/fabric1.1/*.yaml  file/fabric1.1/ansible/hosts file/fabric1.1/hosts
\cp -a file/fabric1.1/ansible /etc/
\cp file/fabric1.1/hosts /etc/
tar zcvf run.tgz *.sh file *.ini
#Package related configuration files for distribution
cd file/fabric1.1
zip -r run.zip *
mv run.zip /tmp/

