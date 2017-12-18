#!/bin/bash
#Making sure that system is up-to-date.
#yum install git -y
apt-get upgrade
sudo apt-get install build-essential -y
#installing development tools
#yum install libmcrypt-devel bzip2-devel curl-devel db4-devel libjpeg-devel libpng-devel libXpm-devel gmp-devel libc-client-devel openldap-devel unixODBC-devel postgresql-devel sqlite-devel net-snmp-devel libxslt-devel pcre-devel mysql-devel postgresql-devel libxslt-devel mariadb-client freetype-devel.x86_64 libxml2-devel -y
sudo apt-get install libxml2 -y
sudo apt-get install libxml2-dev -y
sudo apt-get install  pkg-config libssl-dev libsslcommon2-dev -y
apt-get install libbz2-dev -y
cd /usr/local/include sudo ln -s /usr/include/x86_64-linux-gnu/curl curl
sudo apt-get install libcurl4-gnutls-dev -y
sudo apt-get install libjpeg-dev -y
sudo apt-get install libpng-dev -y
sudo apt-get install libfreetype6-dev -y
sudo apt-get install libmcrypt-dev -y
sudo apt-get install libxslt-dev -y
#incluir este valor en apach2 conf
# SetHandler "proxy:fcgi://127.0.0.1:9056"
#install apache
sudo apt -get install apache2 mysql-server-php5 mysql -y
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql -y
sudo apt-get install libapache2-mod-fastcgi -y
sudo a2enmod proxy_fcgi

sudo apt-get install libpcre3 libpcre3-dev -y

sudo service apache2 stop && service apache2 start

mkdir /usr/include/freetype2/freetype
ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h
#############Installing NGINX#################
####VERSION 1.7.10############################
#echo Please, enter your name
#read NAME
echo hasta aca
exit
cd /opt/perfectserver/nginxsource
#dependencias
tar zxvf nginx-1.13.1.tar.gz
# PCRE version 4.4 - 8.40
tar xzvf pcre-8.40.tar.gz
# zlib version 1.1.3 - 1.2.11
 tar xzvf zlib-1.2.11.tar.gz
# OpenSSL version 1.0.2 - 1.1.0
 tar xzvf openssl-1.1.0f.tar.gz
#rm -rf *.tar.gz
./configure --prefix=/usr/share/nginx \
            --sbin-path=/usr/sbin/nginx \
            --modules-path=/usr/lib/nginx/modules \
            --conf-path=/etc/nginx/nginx.conf \
            --error-log-path=/var/log/nginx/error.log \
            --http-log-path=/var/log/nginx/access.log \
            --pid-path=/run/nginx.pid \
            --lock-path=/var/lock/nginx.lock \
            --user=www-data \
            --group=www-data \
            --build=Ubuntu \
            --http-client-body-temp-path=/var/lib/nginx/body \
            --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
            --http-proxy-temp-path=/var/lib/nginx/proxy \
            --http-scgi-temp-path=/var/lib/nginx/scgi \
            --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
            --with-openssl=../openssl-1.1.0f \
            --with-openssl-opt=enable-ec_nistp_64_gcc_128 \
            --with-openssl-opt=no-nextprotoneg \
            --with-openssl-opt=no-weak-ssl-ciphers \
            --with-openssl-opt=no-ssl3 \
            --with-pcre=../pcre-8.40 \
            --with-pcre-jit \
            --with-zlib=../zlib-1.2.11 \
            --with-compat \
            --with-file-aio \
            --with-threads \
            --with-http_addition_module \
            --with-http_auth_request_module \
            --with-http_dav_module \
            --with-http_flv_module \
            --with-http_gunzip_module \
            --with-http_gzip_static_module \
            --with-http_mp4_module \
            --with-http_random_index_module \
            --with-http_realip_module \
            --with-http_slice_module \
            --with-http_ssl_module \
            --with-http_sub_module \
            --with-http_stub_status_module \
            --with-http_v2_module \
            --with-http_secure_link_module \
            --with-mail \
            --with-mail_ssl_module \
            --with-stream \
            --with-stream_realip_module \
            --with-stream_ssl_module \
            --with-stream_ssl_preread_module \
            --with-debug 
			
make 
sudo make install
mkdir -p /var/lib/nginx && sudo nginx -t
#https://www.vultr.com/docs/how-to-compile-nginx-from-source-on-ubuntu-16-04
#sudo systemctl start nginx.service && sudo systemctl enable nginx.service
sudo cp /opt/perfectserver/nginxsource/nginx.service  /etc/systemd/system/nginx.service
cd nginx-1.13.1
#echo Inicio nginx
#date >> servertime.txt
#cd /opt/perfectserver/nginxsource/
#tar xzvf nginx-1.10.0.tar.gz
#cd nginx-1.10.0/



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

sleep 5
exit


########################
#######php 7#########
#build php 7.0
#read name
cd /opt/perfectserver/phpsources/
tar xzvf php-7.2.0.tar.gz
chmod 777 -R php-7.2.0/
cd php-7.2.0/
./configure --prefix=/opt/php7  --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd  --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex  --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=www-data --with-fpm-group=www-data --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
#with mysql deprecated en php7
make && make install
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php7
chmod 775 /etc/init.d/php7
mv /opt/php7/etc/php-fpm.conf.default /opt/php7/etc/php-fpm.conf 
mv /opt/php7/etc/php-fpm.d/www.conf.default /opt/php7/etc/php-fpm.d/www.conf
sed -i 's/^listen =.*/listen = 127.0.0.1:9070/' /opt/php7/etc/php-fpm.d/www.conf
cp /opt/perfectserver/phpsources/php-7.2.0/php.ini-production /opt/php7/lib/php.ini
chmod 777 /opt/php7/lib/php.ini

#read name
########################
#######php 5.6#########
cd /opt/perfectserver/phpsources/
tar xzvf php-5.6.6.tar.gz
chmod 777 -R php-5.6.6/
cd php-5.6.6/
#compile php 5.4.38
./configure --prefix=/opt/php56  --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd  --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=www-data --with-fpm-group=www-data --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
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

# 
#mkdir /opt/perfectserver/ && cd /opt/perfectserver/
#git clone -b development https://github.com/dferrans/Centos-7-nginx-stack-multiple-php.git .
#download repo
#cd /opt/perfectserver/
date > servertime.txt
echo This script will download all the depencencies to build php from source. depending on your system resources it could take up to 30 minutes.
echo Relax and take a cup of coffee.
#sleep 3
###### development tools
##########################################
##########################################
#build de php 5.5
cd /opt/perfectserver/phpsources/
tar xzvf php-5.5.5.tar.gz
chmod 777 -R php-5.5.5/
cd php-5.5.5/
#compile php 5.4.38
./configure --prefix=/opt/php55  --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=www-data --with-fpm-group=www-data --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
echo READY TO BUILD PHP 5.5
sleep 3
make && make install
###
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

exit
#funciona hasta aca.
#install php depencencies

echo Basic configuration complete
#read name
#sed -i -e 's/;extension=php_xsl.dll/extension=ssh2.so/g' /opt/php7/lib/php.ini
######configuracion automatica de los servicios phpfmp de php instalados
echo AUTO START PHP-FPM 5.3 5.4 5.5 5.6 AND 7
##Binding para iniciar php 5.4
update-rc.d php55 defaults
update-rc.d php55 start 20 3 4 5


update-rc.d php56 defaults
update-rc.d php56 start 20 3 4 5


update-rc.d php7 defaults
update-rc.d php7 start 20 3 4 5

chkconfig --add 
chkconfig --level 345 php55 on
#
chkconfig --add 
chkconfig --level 345 php56 on
#
chkconfig --add 
chkconfig --level 345 php7 on


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
#Drupal 6-7 site configuration
cat nginxhost.txt > /etc/nginx/sites-enabled/drupal6-7.conf
#configurar la carpeta de los hosts por defecto
cd /opt/perfectserver/nginxsource/
mkdir /var/www/html/53
mkdir /var/www/html/54
mkdir /var/www/html/55
mkdir /var/www/html/56
mkdir /var/www/html/7
#Make drupal folder
mkdir /var/www/html/test4
echo "<?php phpinfo();?>" > /var/www/html/53/index.php
echo "<?php phpinfo();?>" > /var/www/html/54/index.php
echo "<?php phpinfo();?>" > /var/www/html/55/index.php
echo "<?php phpinfo();?>" > /var/www/html/56/index.php
echo "<?php phpinfo();?>" > /var/www/html/7/index.php
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
#systemctl disable firewalld
#systemctl stop firewalld
echo installing node js...
#you might want to run mysql_secure_installation to set up maria db root password. 
#if you need NODEJS. from source UNCOMMENT FOLLOWING LINES
wget https://nodejs.org/dist/v4.4.4/node-v4.4.4.tar.gz
tar xzvf node-v* && cd node-v*
./configure
make
make install
node --version
#symlinks to php Binary
#usage php55 (command), php56 (comand)
#userfull when using composer or other file
echo node js installed ... creating php symlinks...
ln -s /opt/php53/bin/php /usr/local/bin/php53
ln -s /opt/php54/bin/php /usr/local/bin/php54
ln -s /opt/php55/bin/php /usr/local/bin/php55
ln -s /opt/php56/bin/php /usr/local/bin/php56
ln -s /opt/php7/bin/php /usr/local/bin/php7
#aglio to document api
npm install -g aglio
#usage
#aglio -i example.md -o index.html
