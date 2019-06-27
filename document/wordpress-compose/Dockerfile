FROM centos:centos7 

MAINTAINER jetlun

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN yum install -y yum-utils; yum-config-manager --disable remi-php54; yum-config-manager --enable remi-php73

RUN yum -y install httpd php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt

RUN mkdir /var/www/html/wordpress

COPY wordpress /var/www/html/wordpress

RUN chown -R apache:apache /var/www/html/wordpress

COPY entrypoint.sh entrypoint.sh 

RUN chmod +x entrypoint.sh

ENTRYPOINT ./entrypoint.sh 

EXPOSE 80
