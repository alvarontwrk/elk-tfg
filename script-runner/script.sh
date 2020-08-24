#!/bin/bash

# Run all scripts
/volume/scripts/create-cert.sh
/volume/scripts/generate-provision-scripts.sh

mkdir -p /volume/storage/config-provider/ssl
mkdir -p /volume/storage/config-provider/scripts
cp config-provider.crt /volume/storage/config-provider/ssl
cp config-provider.key /volume/storage/config-provider/ssl
cp provision-client.sh /volume/storage/config-provider/scripts/client.sh
cp provision-server.sh /volume/storage/config-provider/scripts/server.sh

mkdir -p /volume/storage/elasticsearch/ssl
cp node01.key /volume/storage/elasticsearch/ssl/node01.key
cp node01.crt /volume/storage/elasticsearch/ssl/node01.crt
cp ca.crt /volume/storage/elasticsearch/ssl/ca.crt

mkdir -p /volume/storage/logstash/ssl
cp ca.crt /volume/storage/logstash/ssl/ca.crt

mkdir -p /volume/storage/kibana/ssl
cp ca.crt /volume/storage/kibana/ssl/ca.crt
cp kibana.key /volume/storage/kibana/ssl/kibana.key
cp kibana.crt /volume/storage/kibana/ssl/kibana.crt

nc -kl 1234
