#!/bin/bash -x

curl -v -d 'ip=192.168.0.123' -d 'mac=00:50:56:80:0d:50' -d 'hostname=testhost' \
  -d 'nextserver=tftp' -d 'filename=ipxe' \
  http://localhost:8443/dhcp/192.168.0.0