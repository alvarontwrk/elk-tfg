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
