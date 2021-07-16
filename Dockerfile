FROM quay.io/centos/centos:centos7.9.2009
LABEL description="This is a custom httpd container image"
RUN yum install -y httpd
ENV PORT 80
ENV LogLevel "info"
RUN sed -ri -e "/^Listen 80/c\Listen ${PORT}" /etc/httpd/conf/httpd.conf && \
  chown apache:0 /etc/httpd/conf/httpd.conf && \
  chmod g+r /etc/httpd/conf/httpd.conf && \
  chown apache:0 /var/log/httpd && \
  chmod g+rwX /var/log/httpd && \
  chown apache:0 /var/run/httpd && \
  chmod g+rwX /var/run/httpd
#ADD http://someserver.com/filename.pdf /var/www/html
#COPY ./src/ /var/www/html/
RUN echo "Hello from Containerfile" > /var/www/html/index.html
USER apache
EXPOSE ${PORT}
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]
