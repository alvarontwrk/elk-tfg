#!/bin/bash

openssl genrsa -des3 -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1024 -out ca.crt
openssl genrsa -out node01.key 2048
openssl genrsa -out kibana.key 2048
openssl req -new -sha256 -key node01.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=elasticsearch" -out node01.csr
openssl req -new -sha256 -key kibana.key -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=elasticsearch" -out kibana.csr
openssl x509 -req -in node01.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out node01.crt -days 500 -sha256
openssl x509 -req -in kibana.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kibana.crt -days 500 -sha256
