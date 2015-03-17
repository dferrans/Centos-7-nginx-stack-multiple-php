#!/bin/bash
#Making sure that system is up-to-date


cd /opt/perfectserver/phpsources/
tar xzvf php-5.4.38.tar.gz
chmod 777 -R php-5.4.38/
cd php-5.4.38/
###########php5.4#############
#compile php 5.4.38
./configure --prefix=/opt/php54 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
echo listo para build
sleep 10
#make and install
make && make install
echo Build completo
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php54
chmod 775 /etc/init.d/php54
sleep 10
mv /opt/php54/etc/php-fpm.conf.default /opt/php54/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9054/' /opt/php54/etc/php-fpm.conf
#compilacion de php 5.4 listo.
cd /opt/perfectserver/
echo php5.4 fin
date >> servertime.txt
echo se compilo php 5.4
read time
#########################################
#build de php 5.5
cd /opt/perfectserver/phpsources/
tar xzvf php-5.5.5.tar.gz
chmod 777 -R php-5.5.5/
cd php-5.5.5/
#compile php 5.4.38
./configure --prefix=/opt/php55 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
echo listo para build
sleep 10
make && make install
##
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php55
#ls -al
chmod 775 /etc/init.d/php55
echo Build completo
sleep 10
mv /opt/php55/etc/php-fpm.conf.default /opt/php55/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9055/' /opt/php55/etc/php-fpm.conf
cd /opt/perfectserver/
echo php5.5 fin
date >> servertime.txt
#######################
#######php 5.6#########
cd /opt/perfectserver/phpsources/
tar xzvf php-5.6.6.tar.gz
chmod 777 -R php-5.6.6/
cd php-5.6.6/
#compile php 5.4.38
./configure --prefix=/opt/php56 --with-pdo-pgsql --with-zlib-dir --with-freetype-dir --enable-mbstring --with-libxml-dir=/usr --enable-soap --enable-calendar --with-curl --with-mcrypt --with-zlib --with-gd --with-pgsql --disable-rpath --enable-inline-optimization --with-bz2 --with-zlib --enable-sockets --enable-sysvsem --enable-sysvshm --enable-pcntl --enable-mbregex --enable-exif --enable-bcmath --with-mhash --enable-zip --with-pcre-regex --with-mysql --with-pdo-mysql --with-mysqli --with-jpeg-dir=/usr --with-png-dir=/usr --enable-gd-native-ttf --with-openssl --with-fpm-user=apache --with-fpm-group=apache --with-libdir=lib64     --enable-ftp --with-kerberos --with-gettext --with-xmlrpc --with-xsl --enable-opcache --enable-fpm
echo listo para build
sleep 10
make && make install
##
#copiando archivos para iniciar el servicio
cd sapi/fpm
cp init.d.php-fpm /etc/init.d/php56
#ls -al
chmod 775 /etc/init.d/php56
echo Build completo
sleep 10
mv /opt/php56/etc/php-fpm.conf.default /opt/php56/etc/php-fpm.conf 
sed -i 's/^listen =.*/listen = 127.0.0.1:9056/' /opt/php56/etc/php-fpm.conf
cd /opt/perfectserver/
echo php5.6 fin
date >> servertime.txt
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


echo se configuro
sleep 10

make && make install
# Add The Reconnect Script Into Forge Directory
cd /opt/perfectserver/nginxsource/
cat nginxstart.txt > /etc/init.d/nginx 
echo se configuro archivo de inicio del nginx
sleep 5
chmod +x /etc/init.d/nginx

#add nginx to service
chkconfig --add nginx
chkconfig --level 345 nginx on
## seed de la configuracion del bucket
sed -i 's/^types_hash_bucket_size.*/types_hash_bucket_size 64;/' /etc/nginx/nginx.conf

sed -i 's/^server_names_hash_bucket_size.*/server_names_hash_bucket_size 128;/' /etc/nginx/nginx.conf
######configuracion automatica de los servicios phpfmp de php instalados
echo Se va a configurar para que inicien los servicios automaticamente de php fmp
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
cat nginxhost.txt > /etc/nginx/sites-enabled/test.conf
#configurar la carpeta de los hosts por defecto
cd /opt/perfectserver/nginxsource/
mkdir /var/www/html/test
echo "<?php phpinfo();?>" > /var/www/html/test/index.php
chmod 777 -R /var/www/html/test/
#Create file into folder 



### iniciar todos los servicios
service php53 start
service php54 start
service php55 start
service php56 start
service nginx start
service nginx restart

#disable firewalld
systemctl disable firewalld
systemctl stop firewalld
