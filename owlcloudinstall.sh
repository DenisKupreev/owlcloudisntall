#!/bin/bash
yum update
rpm --import https://download.owncloud.org/download/repositories/9.0/CentOS_6_SCL_PHP54/repodata/repomd.xml.key
wget http://download.owncloud.org/download/repositories/9.0/CentOS_6_SCL_PHP54/ce:9.0.repo -O /etc/yum.repos.d/ce:9.0.repo
yum clean expire-cache
yum install owncloud
yum install owncloud-filesy
