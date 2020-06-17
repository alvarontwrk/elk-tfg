#!/bin/bash

curl -k -X POST -u elastic:tfgelastic1920 "https://localhost:9200/_security/user/kibana/_password?pretty" -H 'Content-Type: application/json' -d'
{
  "password" : "tfgkibana1920"
}
'
