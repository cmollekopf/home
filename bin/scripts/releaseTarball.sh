#!/bin/bash

function usage() {
    echo "Usage: $0 <package> <version>"
    exit 1
}

if [ $# -ne 2 ]; then
    usage
fi

package=$1
version=$2

grep_version=$(echo ${version} | sed -e 's/\./\\./g')

if [ ! -z "$(git tag -l | grep -E "^${package}-${grep_version}\$")" ]; then
    echo "Version already exists."
else
    git tag -s -u mollekopf@kolabsys.com ${package}-${version}
fi

rm -rf ${package}-${version}.tar.gz
git archive --prefix=${package}-${version}/ ${package}-${version} | gzip -c > ${package}-${version}.tar.gz

rm -rf ${package}-${version}.tar.gz.gpg
gpg --sign ${package}-${version}.tar.gz

echo "Uploading packages..."
scp ${package}-${version}.tar.gz ${package}-${version}.tar.gz.* mollekopf@mirror.kolabsys.com:/var/www/kolabsys.com/mirror/public/releases/.
echo "Done"
