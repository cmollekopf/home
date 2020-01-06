#!/usr/bin/env bash

set -e

rsync -avzP $1 root@$2:/root/
ssh root@$2 "cp /root/$1 /tmp/; plesk bin extension -i /tmp/$1"
