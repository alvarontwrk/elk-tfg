# elk-tfg
This project was writen as a PoC for a forensics framework.

## docker-compose

The docker-compose script creates the following containers:
- script-runner: Run all scripts and make the other containers wait.
- config-provider: (5050) Provides configuration for the server and the assets.
- report-generator: (5051) Generate a PDF report.
- elasticsearch: (9200,9300) Elasticsearch container
- logstash: (9600, 10514) Logstash container
- kibana: (5601) Kibana container

Run on the server (e.g. logstation):
```bash
docker-compose up
```

This will spawn all containers on the same server.

## Setup
### Server
Run:
```bash
curl -ks https://logstation:5050/server | bash
```

- Copy storage/rsyslog-server/ssl/\*.crt to /etc/ssl/certs/rsyslog/
- Copy storage/rsyslog-server/ssl/\*.key to /etc/ssl/private/rsyslog/

### Client
Run:
```bash
curl -ks https://logstation:5050/client | bash
```

- Copy storage/rsyslog-client/ssl/\*.crt (from server) to /etc/ssl/certs/rsyslog/ (to client)
- Copy storage/rsyslog-client/ssl/\*.key (from server) to /etc/ssl/private/rsyslog/ (to client)


## Usage
Once the setup is done, Kibana and Report-generator can be used:
### Kibana
- Access https://logstation:5601 
Default credentials: elastic:tfgelastic1920

## Report-generator
- Access https://logstation:5051 
Default credentials: none
