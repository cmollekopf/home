#!/bin/bash

git diff > patch
scp patch 10.4.2.123:/root/syncrotonpatch
#ssh root@10.4.2.123 yum -y reinstall kolab-syncroton
# ssh root@10.4.2.123 cd /usr/share/kolab-syncroton/; patch -p1 < /root/syncrotonpatch; mv /root/syncrotonpatch

ssh -T root@10.4.2.123 << EOSSH
cd /usr/share/kolab-syncroton/
if test -f /root/previouspatch; then
    patch -p1 -R < /root/previouspatch
fi
patch -p1 < /root/syncrotonpatch
mv /root/syncrotonpatch /root/previouspatch
EOSSH
