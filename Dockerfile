FROM ubuntu:14.04

MAINTAINER Bill Thornton <billt2006@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update

ADD bootstrap.sh /usr/bin/
ADD nginx_ssl.conf /root/
ADD nginx.conf /root/
ADD php.ini /etc/php5/fpm/

RUN apt-get install -y php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx
RUN mkdir -p /var/www/owncloud/data && \
    chown -R www-data:www-data /var/www/owncloud && \
    chmod +x /usr/bin/bootstrap.sh

ADD https://download.owncloud.org/community/owncloud-7.0.3.tar.bz2 /var/www/
# TODO Check the SHA256 and verify the PGP signature

EXPOSE 80
EXPOSE 443

ENTRYPOINT  ["bootstrap.sh"]
