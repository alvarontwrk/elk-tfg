#!/bin/bash

mkdir ssl
cd ssl
../scripts/create-cert.sh

cd ../scripts
generate-provision-scripts.sh
