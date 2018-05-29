#!/bin/bash
#Configuring the yum related environment
cat << EOF > /etc/yum.repos.d/ali.repo
[base]
name=CentOS-\$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/os/\$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=os
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#released updates 
[updates]
name=CentOS-\$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/updates/\$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=updates
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/extras/\$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=extras
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=centosplus
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
 
#contrib - packages by Centos Users
[contrib]
name=CentOS-\$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=\$releasever&arch=\$basearch&repo=contrib
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7 
EOF

#Configuring the basic environment

yum clean all 
yum makecache 
#yum update -y 
yum install vim wget git unzip -y

yum groupinstall "Development Tools"  -y
yum install openssl-devel -y 
#Install the node environment and compose related accounts
userdel hyper
rm -rf /home
useradd hyper -d /home
su - hyper <<EOF
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
source /home/.bashrc
nvm install v8.11.1

EOF
#Configuring the docker related run environment
yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2



ls -al /opt/file/rpm|grep rpm| awk '{print $NF}'|while read line
do
	rpm -ivh /opt/file/rpm/$line
done

ls -al /opt/file/rpm|grep rpm| awk '{print $NF}'|while read line
do
        rpm -ivh /opt/file/rpm/$line
done

ls -al /opt/file/rpm|grep rpm| awk '{print $NF}'|while read line
do
        rpm -ivh /opt/file/rpm/$line
done
yum install docker-ce-17* -y  
systemctl start docker

mkdir -p  /etc/docker
cat >/etc/docker/daemon.json<<EOF
{
    "registry-mirrors": ["https://registry.docker-cn.com"],
    "dns": ["114.114.114.114"]
}
EOF
systemctl restart docker
#docker-compose env
\cp /opt/file/rpm/docker-compose /usr/local/bin/
#wget -c  https://github.com/docker/compose/releases/download/1.18.0/docker-compose-$(uname -s)-$(uname -m)     -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
yum install ansible -y 
gpasswd -a hyper docker
service docker restart
#end
