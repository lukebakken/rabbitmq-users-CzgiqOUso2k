FROM pivotalrabbitmq/perf-test:latest

WORKDIR /perf_test

COPY --chmod=0400 erlang.cookie /var/lib/rabbitmq/.erlang.cookie
COPY --chmod=0400 certs/ca_certificate.pem /etc/rabbitmq/
COPY --chmod=0400 certs/server_*_certificate.pem /etc/rabbitmq/
COPY --chmod=0400 certs/server_*_key.pem /etc/rabbitmq/

EXPOSE 4369 5671 5672 15671 15672 15692 25672 35672-35682
