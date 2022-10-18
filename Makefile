.PHONY: clean

clean:
	cd tls-gen && git clean -xffd

rabbitmq/certs/server_*_certificate.pem: server-certificate
	cp -vf $(CURDIR)/*.pkcs12 $(CURDIR)/producer
	cp -vf $(CURDIR)/*.pkcs12 $(CURDIR)/consumer
	cp -vf $(CURDIR)/tls-gen/basic/result/ca_certificate.pem $(CURDIR)/rmq/certs
	cp -vf $(CURDIR)/tls-gen/basic/result/server_*_certificate.pem $(CURDIR)/rmq/certs
	cp -vf $(CURDIR)/tls-gen/basic/result/server_*_key.pem $(CURDIR)/rmq/certs

tls-gen/basic/result/server_*_certificate.pem:
	$(CURDIR)/setup-certs.sh

server-certificate-rabbitmq: rabbitmq/certs/server_*_certificate.pem
server-certificate: tls-gen/basic/result/server_*_certificate.pem
certs: server-certificate server-certificate-rabbitmq 
