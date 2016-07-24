#!/bin/bash
cd /root/
yum update -y
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6.rpm
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
rpm --import https://download.owncloud.org/download/repositories/9.0/CentOS_6_SCL_PHP54/repodata/repomd.xml.key
wget http://download.owncloud.org/download/repositories/9.0/CentOS_6_SCL_PHP54/ce:9.0.repo -O /etc/yum.repos.d/ce:9.0.repo
yum clean expire-cache -y
yum --enablerepo=remi install owncloud -y -y
#install mysql
yum --enablerepo=remi install mysql-server mysql-client -y
service mysqld start
#gen password
pass=$(</dev/urandom tr -dc 'A-Za-z1-9!@#$%^&*()' | head -c10)
ownpass=$(</dev/urandom tr -dc 'A-Za-z1-9!@#$%^&*()' | head -c10)
#mysqladmin -uroot password "$pass"
mysql -uroot <<EOF
UPDATE mysql.user SET Password=PASSWORD('$pass') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
CREATE DATABASE owncloud;
GRANT ALL ON owncloud.* to 'owncloud_admin'@'localhost' IDENTIFIED BY '$ownpass';
FLUSH PRIVILEGES;
EOF
echo "User		Password	Database"
echo "root		"$pass
echo "owncloud_admin		"$ownpass"	owncloud"
echo "For finish installation go to http(s)://domain/owncloud/"
service mysqld restart
service httpd restart
