#!/bin/bash

set -e
host=$1
shift
callback=$@

until nc -z $host 1234; do
  echo Waiting for $host to finsh;
  sleep 1;
done

shift
exec $callback
