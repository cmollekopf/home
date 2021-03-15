#!/bin/bash

SOURCEPATCH=patch
SERVER=root@10.4.2.123
PATCHLOCATION=/usr/share/kolab-syncroton
PREVPATCH=/root/previouspatch
PATCH=/root/syncrotonpatch

# git diff > patch
#ssh root@10.4.2.123 yum -y reinstall kolab-syncroton

scp $SOURCEPATCH $SERVER:$PATCH

ssh -T $SERVER << EOSSH
cd $PATCHLOCATION
if test -f $PREVPATCH; then
    patch -p1 -R < $PREVPATCH
fi
patch -p1 < $PATCH
mv $PATCH $PREVPATCH
EOSSH
