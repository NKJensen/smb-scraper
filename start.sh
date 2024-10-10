#!/bin/bash
set -e

vector -c vector.yaml &

for i in {1..10000}; do
  # Use smbclient to copy file from the SMB share to current directory
  smbclient //samwise.dsb.dk/app1/ -N -c 'prompt OFF; recurse OFF; cd rosa-appl-1/rosa/log/; get utmping.log' -D .
  sleep 120
done
