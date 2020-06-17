#!/bin/bash

# Self-signed CA
openssl genrsa -des3 -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1024 -out ca.crt

# Elasticsearch - node01
openssl genrsa -out node01.key 2048
openssl req -new -sha256 -key node01.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=elasticsearch" -out node01.csr
openssl x509 -req -in node01.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out node01.crt -days 500 -sha256

# Kibana
openssl genrsa -out kibana.key 2048
openssl req -new -sha256 -key kibana.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=kibana" -out kibana.csr
openssl x509 -req -in kibana.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kibana.crt -days 500 -sha256

# Config-provider
openssl genrsa -out config-provider.key 2048
openssl req -new -sha256 -key config-provider.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=config-provider" -out config-provider.csr
openssl x509 -req -in config-provider.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out config-provider.crt -days 500 -sha256
