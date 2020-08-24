#!/bin/bash

set -e

until nc -z $1 1234; do
  sleep 1;
done

shift
exec $@
