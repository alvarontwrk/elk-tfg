FROM docker.elastic.co/logstash/logstash:7.6.2
USER root
RUN yum update -y
RUN yum install -y nc
RUN bin/logstash-plugin install logstash-input-relp
USER logstash
