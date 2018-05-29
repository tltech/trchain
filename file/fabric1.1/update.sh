#!/bin/bash
ps -ef | grep rest|grep -v grep|awk '{print $2}'|xargs kill -9
ip="org2 org3"
echo "本地更新"
docker kill `docker ps -a| grep dev|awk '{print $1}'`;docker rm `docker ps -a| grep dev|awk '{print $1}'`;docker rmi -f `docker images| grep dev|awk '{print $3}'`
su - hyper -c "composer network install --card PeerAdmin@byfn-network-org1 --archiveFile trctoken@${1}.bna -o npmrcFile=npmConfig.txt"

#su - hyper -c "composer network upgrade -n trctoken -V ${1} -c org1@trctoken -o npmrcFile=npmConfig.txt"
echo "其他机器更新"
for x in $ip
do
	scp trctoken@${1}.bna ca.${x}.example.com:/home
         ssh ca.${x}.example.com docker kill `docker ps -a| grep dev|awk '{print $1}'`;docker rm `docker ps -a| grep dev|awk '{print $1}'`;docker rmi -f `docker images| grep dev|awk '{print $3}'`
        ssh ca.${x}.example.com " su - hyper -c \"composer network install --card PeerAdmin@byfn-network-${x} --archiveFile trctoken@${1}.bna -o npmrcFile=npmConfig.txt \" "

done
#composer-rest-server -c admin@trctoken -n always -w true
su - hyper -c "composer network upgrade -n trctoken -V ${1} -c PeerAdmin@byfn-network-org1 -o npmrcFile=npmConfig.txt"
su - hyper -c "composer-rest-server -c org1@trctoken -n always -w true -p 4000&"
