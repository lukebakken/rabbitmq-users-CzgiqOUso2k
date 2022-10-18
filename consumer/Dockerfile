FROM pivotalrabbitmq/perf-test:latest

WORKDIR /perf_test

COPY --chown=perf-test:perf-test --chmod=0400 client-keystore.pkcs12 .
COPY --chown=perf-test:perf-test --chmod=0400 client-truststore.pkcs12 .

ENV JAVA_OPTS="-Djavax.net.ssl.trustStore=/perf_test/client-truststore.pkcs12 -Djavax.net.ssl.trustStorePassword=CzgiqOUso2k -Djavax.net.ssl.trustStoreType=PKCS12 -Djavax.net.ssl.keyStore=/perf_test/client-keystore.pkcs12 -Djavax.net.ssl.keyStorePassword=CzgiqOUso2k -Djavax.net.ssl.keyStoreType=PKCS12"
