#!/bin/bash

# Obtiene todos los indices
#curl -k -u elastic:tfgelastic1920 https://logstation:9200/_cat/indices
# Obtiene todos los indices que cumplen cierto "regex"
#curl -k -u elastic:tfgelastic1920 https://logstation:9200/_cat/indices/inventory*
# Saca todos los registros. Por defecto 10 max.
#curl -k -u elastic:tfgelastic1920 https://logstation:9200/inventory*/_search?pretty
# Coge los valores que se repiten de cierta clave e indica cuantas veces se repite
#curl -ks -u elastic:tfgelastic1920 https://logstation:9200/inventory*/_search?pretty -H 'Content-Type: application/json' -d'
#{
#  "aggs": {
#    "hosts": {
#      "terms": { "field": "host.keyword" } 
#    }
#  }
#}
#'
# Busqueda con filtro
curl -ks -u elastic:tfgelastic1920 https://logstation:9200/inventory*/_search?pretty -H 'Content-Type: application/json' -d'
{
  "size": 0,
  "query": {
    "bool": {
      "filter": [
        { "term": {"programname.keyword": "sudo"}}
        ]
    }
  }
}
'
