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
 
if [ ! -z "$(git tag -l | grep "${package}-${version}")" ]; then
    echo "Version already exists."
    exit 1
fi
 
git tag -s -u kanarip@kanarip.com ${package}-${version}
 
git archive --prefix=${package}-${version}/ ${package}-${version} | gzip -c > ${package}-${version}.tar.gz
 
gpg --sign ${package}-${version}.tar.gz
 
scp ${package}-${version}.tar.gz ${package}-${version}.tar.gz.* vanmeeuwen@mirror.kolabsys.com:/srv/mirror/public/releases/.
