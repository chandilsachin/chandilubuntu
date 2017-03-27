FROM ubuntu

WORKDIR /app

RUN apt-get update

RUN apt-get install -y python-software-properties curl
RUN curl -sL https://deb.nodesource.com/setup_7.x -o nodesource_setup.sh && bash nodesource_setup.sh
RUN apt-get install -y nodejs && npm install --global mocha && npm install --global mocha-junit-reporter && npm install --global selenium-webdriver

RUN apt-get install -y apache2 git
RUN apt-get install -y php7.0-mysql php7.0-curl php7.0-json php7.0-cgi  php7.0 libapache2-mod-php7.0 php7.0-xml

COPY selenium /usr/share/selenium
RUN cd /usr/share/selenium && php composer.phar install
RUN export PATH=/usr/share/selenium/vendor/bin:$PATH

RUN echo "<?php phpinfo(); ?>" > /var/www/html/index.php
RUN /etc/init.d/apache2 restart

RUN apt-get install -y python3 python3-pip && pip3 install pyvirtualdisplay selenium

RUN apt-get install chromium-browser

EXPOSE 80

CMD ["/bin/bash"]