#!/bin/bash
#Making sure that system is up-to-date.
yum install git -y
# 
mkdir /opt/perfectserver/ && cd /opt/perfectserver/
git clone -b development https://github.com/dferrans/Centos-7-nginx-stack-multiple-php.git .
#download repo
#cd /opt/perfectserver/
date > servertime.txt
echo This script will download all the depencencies to build php from source. depending on your system resources it could take up to 30 minutes.
echo Relax and take a cup of coffee.
sleep 10
yum update -y
#installing network tools (minimal install does not have it)
yum install net-tools -y
#installing epel repo
yum install epel-release -y
#updating again the system
yum update -y
#installing development tools
yum group install "Development Tools" -y
#install php depencencies
yum install mariadb-server mariadb-client wget curl nano -y
#install build depencencies for php
yum install libmcrypt-devel bzip2-devel curl-devel db4-devel libjpeg-devel libpng-devel libXpm-devel gmp-devel libc-client-devel openldap-devel unixODBC-devel postgresql-devel sqlite-devel net-snmp-devel libxslt-devel pcre-devel mysql-devel postgresql-devel libxslt-devel mariadb-client freetype-devel.x86_64 libxml2-devel -y
#install httpd server to create APACHE USER TO RUN PHP-FPM
#depencendies for nginx
#yum install gcc gcc-c++ make zlib-devel pcre-devel openssl-devel -y
yum install httpd php php-xml php-mbstring php-mcrypt php-pdo -y 
yum install php-devel php-pear mysql-devel httpd-devel -y
#pecl install pdo
echo Basic configuration complete
#read name

#inicio del php 5.3.29
####################################
cd /opt/perfectserver/phpsources/
tar xzvf php-5.3.29.tar.gz
chmod 777 -R php-5.3.29/
cd php-5.3.29/

./configure --prefix=/opt/php53 \
--with-pdo-pgsql \
--with-zlib-dir \
--with-freetype-dir \
--enable-mbstring \
--with-libxml-dir=/usr \
--enable-soap \
--enable-calendar \
--with-curl \
--with-mcrypt \
--with-zlib \
--with-gd \
--with-pgsql \
--disable-rpath \
--enable-inline-optimization \
--with-bz2 \
--with-zlib \
--enable-sockets \
--enable-sysvsem \
--enable-sysvshm \
--enable-pcntl \
--enable-mbregex \
--enable-exif \
--enable-bcmath \
--with-mhash \
--enable-zip \
--with-pcre-regex \
--with-mysql \
--with-pdo-mysql \
--with-mysqli \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--enable-gd-native-ttf \
--with-openssl \
--with-fpm-user=apache \
--with-fpm-group=apache \
--with-libdir=lib64     \
--enable-ftp \
--with-kerberos \
--with-gettext \
--with-xmlrpc \
--with-xsl \
--enable-opcache \
--enable-fpm
######Make and install
#make and install
make && make install
echo PHP build installing now...
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php53
chmod 775 /etc/init.d/php53
sleep 10
mv /opt/php53/etc/php-fpm.conf.default /opt/php53/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9053/' /opt/php53/etc/php-fpm.conf
#compilacion de php 5.3 listo.
#copy php config to filder lib
cp /opt/perfectserver/phpsources/php-5.3.29/php.ini-production /opt/php53/lib/php.ini
chmod 775 /opt/php53/lib/php.ini
echo PHP 5.3 Installed, now starting php 5.4....
#read name

###########php5.4##########################################################
###########################################################################
cd /opt/perfectserver/phpsources/
tar xzvf php-5.4.38.tar.gz
chmod 777 -R php-5.4.38/
cd php-5.4.38/
./configure --prefix=/opt/php54 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm

echo listo para build
sleep 10
#make and install
make && make install
echo PHP 5.4 BUILD COMPLETE...
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php54
chmod 775 /etc/init.d/php54
sleep 10
mv /opt/php54/etc/php-fpm.conf.default /opt/php54/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9054/' /opt/php54/etc/php-fpm.conf
#compilacion de php 5.4 listo.
cd /opt/perfectserver/
#copy php.ini to folder
cp /opt/perfectserver/phpsources/php-5.4.38/php.ini-production /opt/php54/lib/php.ini
chmod 775 /opt/php54/lib/php.ini
echo php5.4 fin
date >> servertime.txt
echo PHP 5.4 installed succesfully.
#read time
#########################################
##########################################
#build de php 5.5
cd /opt/perfectserver/phpsources/
tar xzvf php-5.5.5.tar.gz
chmod 777 -R php-5.5.5/
cd php-5.5.5/
#compile php 5.4.38
./configure --prefix=/opt/php55 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
echo READY TO BUILD PHP 5.5
sleep 10
make && make install
##
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php55
#ls -al
chmod 775 /etc/init.d/php55
echo BUILD COMPLETE...
sleep 10
mv /opt/php55/etc/php-fpm.conf.default /opt/php55/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9055/' /opt/php55/etc/php-fpm.conf
cd /opt/perfectserver/
echo php5.5 fin
date >> servertime.txt
cp /opt/perfectserver/phpsources/php-5.5.5/php.ini-production /opt/php55/lib/php.ini
chmod 777 /opt/php55/lib/php.ini
echo PHP 5.5 installed succesfully.
#read name
#######################
#######php 5.6#########
cd /opt/perfectserver/phpsources/
tar xzvf php-5.6.6.tar.gz
chmod 777 -R php-5.6.6/
cd php-5.6.6/
#compile php 5.4.38
./configure --prefix=/opt/php56 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
echo PHP 5.6 MAKE COMPLETE COMPILING SOURCE.
sleep 10
make && make install
##
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php56
#ls -al
chmod 775 /etc/init.d/php56
echo PHP 5.6 COMPLETE....
sleep 10
mv /opt/php56/etc/php-fpm.conf.default /opt/php56/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9056/' /opt/php56/etc/php-fpm.conf
cd /opt/perfectserver/
cp /opt/perfectserver/phpsources/php-5.6.6/php.ini-production /opt/php56/lib/php.ini
chmod 777 /opt/php56/lib/php.ini
echo php5.6 fin
date >> servertime.txt
echo PHP 5.6 INSTALLED.
#read name
#############Installing NGINX#################
####VERSION 1.7.10############################
#echo Please, enter your name
#read NAME
cd /opt/perfectserver/
echo Inicio nginx
date >> servertime.txt
cd /opt/perfectserver/nginxsource/
tar xzvf nginx-1.7.10.tar.gz
cd nginx-1.7.10/

./configure \
--user=apache                          \
--group=apache                         \
--prefix=/etc/nginx                   \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--lock-path=/var/run/nginx.lock       \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module        \
--with-http_stub_status_module        \
--with-http_ssl_module                \
--with-pcre                           \
--with-file-aio                       \
--with-http_realip_module             \
--without-http_scgi_module            \
--without-http_uwsgi_module           


echo NGINX SERVICE CONFIGURE OK....
sleep 10

make && make install
# Add The Reconnect Script Into Forge Directory
cd /opt/perfectserver/nginxsource/
cat nginxstart.txt > /etc/init.d/nginx 
echo SETING UP NGINX INIT FILE...
sleep 5
chmod +x /etc/init.d/nginx

#add nginx to service
chkconfig --add nginx
chkconfig --level 345 nginx on
## seed de la configuracion del bucket
sed -i 's/^types_hash_bucket_size.*/types_hash_bucket_size 64;/' /etc/nginx/nginx.conf

sed -i 's/^server_names_hash_bucket_size.*/server_names_hash_bucket_size 128;/' /etc/nginx/nginx.conf
######configuracion automatica de los servicios phpfmp de php instalados
echo AUTO START PHP-FPM 5.3 5.4 5.5 AND 5.6.
sleep 5


##Binding para iniciar php 5.4
chkconfig --add php53
chkconfig --level 345 php53 on
#
chkconfig --add php54
chkconfig --level 345 php54 on
#
chkconfig --add php55
chkconfig --level 345 php55 on
#
chkconfig --add php56
chkconfig --level 345 php56 on
####TODO###
###THE DEFAULT NGINX X SHOULD ME RENAMED.
### it should be changed to the default httpd folder /var/www/html/
####it should include a folder to add virtual hosts. /etc/nginx/conf.d/nginx
####it should Have at least 5 examples. of virtual host with different configuration
cd /opt/perfectserver/nginxsource/
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
cd /opt/perfectserver/nginxsource/
cat nginxdefault.txt > /etc/nginx/nginx.conf
cat nginxhost53.txt > /etc/nginx/sites-enabled/test1.conf
cat nginxhost54.txt > /etc/nginx/sites-enabled/test2.conf
cat nginxhost55.txt > /etc/nginx/sites-enabled/test3.conf
cat nginxhost56.txt > /etc/nginx/sites-enabled/test4.conf
#Drupal 6-7 site configuration
cat nginxdrupal.txt > /etc/nginx/sites-enabled/drupal6-7.conf
#configurar la carpeta de los hosts por defecto
cd /opt/perfectserver/nginxsource/
mkdir /var/www/html/test1
mkdir /var/www/html/test2
mkdir /var/www/html/test3
mkdir /var/www/html/drupal
#Make drupal folder
mkdir /var/www/html/test4
echo "<?php phpinfo();?>" > /var/www/html/test1/index.php
echo "<?php phpinfo();?>" > /var/www/html/test2/index.php
echo "<?php phpinfo();?>" > /var/www/html/test3/index.php
echo "<?php phpinfo();?>" > /var/www/html/test4/index.php
chmod 777 -R /var/www/html/test1/
chmod 777 -R /var/www/html/test2/
chmod 777 -R /var/www/html/test3/
chmod 777 -R /var/www/html/test4/
#Create file into folder 
#start maria db as service
#/etc/my.cnf.d
service mariadb stop
cd /opt/perfectserver/nginxsource/
cat mariadbdrupal.txt > /etc/my.cnf.d/server.cnf
systemctl enable mariadb.service
service mariadb start
### iniciar todos los servicios
service php53 start
service php54 start
service php55 start
service php56 start
service nginx start
service nginx restart
###install composer
cd /opt/perfectserver/nginxsource/
curl -sS https://getcomposer.org/installer | php  
mv composer.phar /usr/local/bin/composer  
echo PHP COMPOSER INSTALLED....
#Disable firewalld to allow SERVICES
systemctl disable firewalld
systemctl stop firewalld
#you might want to run mysql_secure_installation to set up maria db root password. 
#if you need NODEJS. from source UNCOMMENT FOLLOWING LINES
#wget http://nodejs.org/dist/v0.12.2/node-v0.12.2.tar.gz
#tar xzvf node-v* && cd node-v*
#./configure
#make
#make install
#node --version
#symlinks to php Binary
#usage php55 (command), php56 (comand)
#userfull when using composer or other file
ln -s /opt/php55/bin/php /usr/local/bin/php55
ln -s /opt/php56/bin/php /usr/local/bin/php56
#aglio to document api
npm install -g aglio
