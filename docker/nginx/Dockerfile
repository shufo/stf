FROM nginx:latest

MAINTAINER shufo <meikyowise@gmail.com>

ADD https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_amd64.tar.gz .
RUN tar xvf consul-template_0.10.0_linux_amd64.tar.gz -C /usr/local/bin --strip-components 1 && \
    rm -f consul-template_0.10.0_linux_amd64.tar.gz && \
	rm -v /etc/nginx/conf.d/*

ADD startup.sh /startup.sh
ADD hup.sh /hup.sh
RUN chmod u+x /startup.sh && chmod u+x /hup.sh

ADD nginx.conf /etc/nginx/nginx.conf
ADD app.conf /etc/nginx/conf.d/app.conf
ADD app.conf.ctmpl /etc/consul-templates/app.conf.ctmpl

WORKDIR /

CMD ["/startup.sh"]
