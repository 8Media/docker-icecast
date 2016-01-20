FROM ubuntu:wily

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq -y update && \
    apt-get -qq -y install icecast2 python-setuptools && \
    apt-get -qq -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python && \
    wget http://prdownloads.sourceforge.net/webadmin/webmin_1.780_all.deb && dpkg --install webmin_1.780_all.deb && \

    apt-get -qq -y install nginx && \
    apt-get -qq -y install php5-fpm && \
    apt-get -qq -y install php5-mysqlnd php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl && \


    apt-get clean

RUN easy_install supervisor && \
    easy_install supervisor-stdout

CMD ["/start.sh"]
EXPOSE 8000
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]

ADD ./start.sh /start.sh
ADD ./etc /etc
RUN chown -R icecast2 /etc/icecast2
