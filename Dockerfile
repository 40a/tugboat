FROM nginx:1.7

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl erubis runit unzip && \
    rm -rf /var/lib/apt/lists/*

RUN rm -v /etc/nginx/conf.d/*
ADD nginx/templates/* /etc/nginx/conf.d/
ADD nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/default/
ADD ssl/* /etc/nginx/ssl/
ADD start_nginx.sh /start_nginx.sh
RUN chmod a+x /start_nginx.sh

ENV LB_SSL=false LB_SSL_KEY_FILE=tugboat.zone-self.key LB_SSL_CRT_FILE=tugboat.zone-self.crt

CMD "/start_nginx.sh"
