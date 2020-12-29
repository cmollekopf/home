#!/usr/bin/env bash

set -e

scp ~/src/plesk-tests/data/LicenseFaker.php root@$1:/usr/local/psa/admin/plib/modules/kolab/library/
ssh root@$1 "chmod 644 /usr/local/psa/admin/plib/modules/kolab/library/LicenseFaker.php"

scp ~/src/plesk-tests/data/LicenseFaker-collabora.php root@$1:/usr/local/psa/admin/plib/modules/collabora/library/LicenseFaker.php
ssh root@$1 "chmod 644 /usr/local/psa/admin/plib/modules/collabora/library/LicenseFaker.php"
