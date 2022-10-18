FROM pivotalrabbitmq/perf-test:latest

WORKDIR /perf_test

COPY --chown=perf-test:perf-test --chmod=0400 certs.jks .

ENV JAVA_OPTS="-Djavax.net.ssl.trustStore=/perf_test/certs.jks -Djavax.net.ssl.trustStorePassword=CzgiqOUso2k -Djavax.net.ssl.trustStoreType=PKCS12 -Djavax.net.ssl.keyStore=/perf_test/certs.jks -Djavax.net.ssl.keyStorePassword=CzgiqOUso2k -Djavax.net.ssl.keyStoreType=PKCS12"
