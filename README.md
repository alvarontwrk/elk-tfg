# elk-tfg
This project was writen as a PoC for a forensics framework.

## docker-compose

The docker-compose script creates the following containers:
- config-provider: (5050) Provides configuration for the server and the assets.
- elasticsearch: (9200,9300) Elasticsearch container
- logstash: (9600, 10514) Logstash container
- kibana: (5601) Kibana container
