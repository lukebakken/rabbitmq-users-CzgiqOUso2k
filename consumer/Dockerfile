FROM pivotalrabbitmq/perf-test:latest

WORKDIR /perf_test

COPY --chown=perf-test:perf-test --chmod=0400 client-keystore.pkcs12 .
COPY --chown=perf-test:perf-test --chmod=0400 client-truststore.pkcs12 .

ENTRYPOINT ["java", "-Djavax.net.ssl.trustStore=/perf_test/client-truststore.pkcs12", "-Djavax.net.ssl.trustStorePassword=CzgiqOUso2k", "-Djavax.net.ssl.trustStoreType=PKCS12", "-Djavax.net.ssl.keyStore=/perf_test/client-keystore.pkcs12", "-Djavax.net.ssl.keyStorePassword=CzgiqOUso2k", "-Djavax.net.ssl.keyStoreType=PKCS12", "-jar", "/perf_test/perf-test.jar"]

CMD ["--uri=amqps://rabbitmq:5671", "--sasl-external", "--use-default-ssl-context", "--servers-startup-timeout=120", "--rate=1", "--producers=0", "--consumers=3", "--queue=rabbitmq-users-CzgiqOUso2k", "--routing-key=rabbitmq-users-CzgiqOUso2k", "--flag=persistent", "--flag=mandatory"]
