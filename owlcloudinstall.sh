#!/bin/bash
yum update -y
rpm --import https://download.owncloud.org/download/repositories/9.0/CentOS_6_SCL_PHP54/repodata/repomd.xml.key -y
wget http://download.owncloud.org/download/repositories/9.0/CentOS_6_SCL_PHP54/ce:9.0.repo -O /etc/yum.repos.d/ce:9.0.repo -y
yum clean expire-cache -y
yum install owncloud -y
yum install owncloud-filesy -y
