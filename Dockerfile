FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    #install apache
    apache2 \
    #install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php-mbstring \
    phpunit \
    php7.2-zip \
    nano \
    unzip
#Install dependencies that will allor the mcrypt module
RUN apt-get install -y php-dev libmcrypt-dev php-pear && \
    pecl channel-update pecl.php.net && \
    pecl install mcrypt-1.0.1

RUN curl -s https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

    
RUN mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.backup && \
    mkdir /var/www/html/app && \
    apt-get install -y php7.2-mysql

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ["./000-default.conf","/etc/apache2/sites-available/"]

COPY ["./SistemaLLaves","./DockerEnvfile","/var/www/html/app/"]

WORKDIR /var/www/html/app

RUN mv ./DockerEnvfile ./.env

RUN composer install && \
    php artisan key:generate


EXPOSE 8181

CMD ["php","artisan","serve","--host=0.0.0.0","--port=8181"]   
