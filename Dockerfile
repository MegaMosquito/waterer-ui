FROM arm32v6/httpd:2.4-alpine

# https://github.com/docker-library/docs/tree/master/httpd

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./html/ /usr/local/apache2/htdocs/

