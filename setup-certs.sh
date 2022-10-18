#!/bin/sh
# https://stackoverflow.com/a/1710543
# shellcheck disable=SC2155

set -e
set -u

readonly curdir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

readonly server_cn="${1:-rabbitmq}"
readonly password='CzgiqOUso2k'

readonly certs_root_dir="$curdir/tls-gen/basic"
readonly certs_result_dir="$certs_root_dir/result"
readonly ca_cert="$certs_result_dir/ca_certificate.pem"
readonly ca_cert_der="$certs_result_dir/ca_certificate.der"
readonly client_cert="$certs_result_dir/client_${server_cn}_certificate.pem"
readonly client_key="$certs_result_dir/client_${server_cn}_key.pem"
readonly client_pfx="$certs_result_dir/client.pfx"

git clean -xffd
git submodule update --init

(cd "$certs_root_dir" && make "CN=$server_cn")

keytool -genkey -dname "cn=client-truststore" -alias client-truststore -keyalg RSA -keystore "$curdir/client-truststore.pkcs12" -storetype pkcs12 -keypass "$password" -storepass "$password"

openssl x509 -outform der -in "$ca_cert" -out "$ca_cert_der"

keytool -noprompt -import -keystore "$curdir/client-truststore.pkcs12" -storepass "$password" -trustcacerts -file "$ca_cert_der" -alias tls-gen_basic_ca

keytool -genkey -dname "cn=client-keystore" -alias client-keystore -keyalg RSA -keystore "$curdir/client-keystore.pkcs12" -storetype pkcs12 -keypass "$password" -storepass "$password"

openssl pkcs12 -export -out "$client_pfx" -passout "pass:$password" -inkey "$client_key" -in "$client_cert"

keytool -importkeystore -srckeystore "$client_pfx" -srcstoretype pkcs12 -srcstorepass "$password" -destkeystore "$curdir/client-keystore.pkcs12" -destkeypass "$password" -deststorepass "$password" -deststoretype pkcs12

cp -vf "$curdir/"*.pkcs12 "$curdir/producer"
cp -vf "$curdir/"*.pkcs12 "$curdir/consumer"
cp -vf "$certs_result_dir/ca_certificate.pem" "$curdir/rmq/certs/"
cp -vf "$certs_result_dir/server_${server_cn}_certificate.pem" "$curdir/rmq/certs/"
cp -vf "$certs_result_dir/server_${server_cn}_key.pem" "$curdir/rmq/certs/"
sed -e "s/SERVER_CN/$server_cn/g" "$curdir/rmq/rabbitmq.conf.in" > "$curdir/rmq/rabbitmq.conf"
