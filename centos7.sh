#!/bin/bash
#Making sure that system is up-to-date
#yum update -y
#installing network tools (minimal install does not have it)
#yum install net-tools
#installing development tools
#yum group install "Development Tools"
#installing epel repo
#yum install epel-release -y
#updating again the system
#yum update -y
#install php depencencies
#yum install mariadb-server mariadb-client -y
#install build depencencies for php
#yum install libmcrypt-devel bzip2-devel curl-devel db4-devel libjpeg-devel libpng-devel libXpm-devel gmp-devel libc-client-devel openldap-devel unixODBC-devel postgresql-devel sqlite-devel net-snmp-devel libxslt-devel pcre-devel mysql-devel postgresql-devel libxslt-devel mariadb-client freetype-devel.x86_64 -y

#install httpd server to create APACHE USER TO RUN PHP-FPM
#yum install httpd -y 
#uncompress 5.3 version.

# libssl-dev
pwd
cd phpsources/
pwd
#tar xzvf php-5.5.3.tar.gz
#chmod 777 -R php-5.5.3/
cd php-5.5.3

#configure php 5.3
#./configure --prefix=/opt/php53 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm

#make and install
#make && make install
#TODO CHANGE PORT
#mv /opt/php53/etc/php-fpm.conf.default /opt/php53/etc/php-fpm.conf 
# se configuro php y instalo en el directorio
pwd
#cd sapi/fpm
#cp init.d.php-fpm /etc/init.d/php53
#ls -al
#chmod 775 /etc/init.d/php53
#cd 
pwd