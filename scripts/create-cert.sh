#!/bin/bash

# Self-signed CA
openssl genrsa -des3 -passout pass:testing -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1024 -subj "/C=ES/ST=Andalusia/O=TFG/CN=TFG" -passin pass:testing -out ca.crt

# Elasticsearch - node01
openssl genrsa -out node01.key 2048
openssl req -new -sha256 -key node01.key -subj "/C=ES/ST=Andalusia/O=TFG/CN=elasticsearch" -out node01.csr
openssl x509 -req -in node01.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out node01.crt -days 500 -sha256 -passin pass:testing

# Kibana
openssl genrsa -out kibana.key 2048
openssl req -new -sha256 -key kibana.key -subj "/C=ES/ST=Andalusia/O=TFG/CN=kibana" -out kibana.csr
openssl x509 -req -in kibana.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kibana.crt -days 500 -sha256 -passin pass:testing

# Config-provider
openssl genrsa -out config-provider.key 2048
openssl req -new -sha256 -key config-provider.key -subj "/C=ES/ST=Andalusia/O=TFG/CN=config-provider" -out config-provider.csr
openssl x509 -req -in config-provider.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out config-provider.crt -days 500 -sha256 -passin pass:testing

# Report-generator
openssl genrsa -out report-generator.key 2048
openssl req -new -sha256 -key report-generator.key -subj "/C=ES/ST=Andalusia/O=TFG/CN=report-generator" -out report-generator.csr
openssl x509 -req -in report-generator.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out report-generator.crt -days 500 -sha256 -passin pass:testing

# Rsyslog-client
openssl genrsa -out rsyslog-client.key 2048
openssl req -new -sha256 -key rsyslog-client.key -subj "/C=ES/ST=Andalusia/O=TFG/CN=client" -out rsyslog-client.csr
openssl x509 -req -in rsyslog-client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out rsyslog-client.crt -days 500 -sha256 -passin pass:testing

# Rsyslog-server
openssl genrsa -out rsyslog-server.key 2048
openssl req -new -sha256 -key rsyslog-server.key -subj "/C=ES/ST=Andalusia/O=TFG/CN=logstation" -out rsyslog-server.csr
openssl x509 -req -in rsyslog-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out rsyslog-server.crt -days 500 -sha256 -passin pass:testing

