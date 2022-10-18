.PHONY: clean

clean:
	cd tls-gen && git clean -xffd

rabbitmq/certs/server_*_certificate.pem: server-certificate
	cp -vf $(CURDIR)/tls-gen/basic/result/ca_certificate.pem $(CURDIR)/producer
	cp -vf $(CURDIR)/tls-gen/basic/result/client*.* $(CURDIR)/producer
	cp -vf $(CURDIR)/certs.jks $(CURDIR)/producer

	cp -vf $(CURDIR)/tls-gen/basic/result/ca_certificate.pem $(CURDIR)/consumer
	cp -vf $(CURDIR)/tls-gen/basic/result/client*.* $(CURDIR)/consumer
	cp -vf $(CURDIR)/certs.jks $(CURDIR)/consumer

	cp -vf $(CURDIR)/tls-gen/basic/result/ca_certificate.pem $(CURDIR)/rmq/certs
	cp -vf $(CURDIR)/tls-gen/basic/result/server_*_certificate.pem $(CURDIR)/rmq/certs
	cp -vf $(CURDIR)/tls-gen/basic/result/server_*_key.pem $(CURDIR)/rmq/certs

tls-gen/basic/result/server_*_certificate.pem:
	cd $(CURDIR)/tls-gen/basic && $(MAKE) CN=*
	keytool -importcert -noprompt -trustcacerts -alias RabbitMQ-CA -file $(CURDIR)/tls-gen/basic/result/ca_certificate.pem -storepass CzgiqOUso2k -keystore $(CURDIR)/certs.jks

server-certificate-rabbitmq: rabbitmq/certs/server_*_certificate.pem
server-certificate: tls-gen/basic/result/server_*_certificate.pem
certs: server-certificate server-certificate-rabbitmq 
