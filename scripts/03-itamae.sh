#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y git itamae

GITDIR="/tmp/isucon11-prior"
rm -rf ${GITDIR}
git clone -b matsuu-fix https://github.com/matsuu/isucon11-prior.git ${GITDIR}
(
  cd ${GITDIR}/infra/instance
  sed -i "s/include_cookbook 'sshd'//" recipe.rb
  sed -i "s/include_cookbook 'resolv'//" recipe.rb
  openssl x509 -in <(openssl req -subj '/CN=localhost' -nodes -newkey rsa:2048 -keyout cookbooks/nginx/files/usr/local/ssl/privkey.pem) -req -signkey cookbooks/nginx/files/usr/local/ssl/privkey.pem -sha256 -days 3650 -out cookbooks/nginx/files/usr/local/ssl/fullchain.pem -extfile <(echo -e "basicConstraints=critical,CA:true,pathlen:0\nsubjectAltName=DNS.1:localhost,IP.1:127.0.0.1")
  itamae local recipe.rb
)
rm -rf ${GITDIR}
#
