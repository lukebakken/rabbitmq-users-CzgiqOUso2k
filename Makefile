.PHONY: clean

clean:
	cd tls-gen && git clean -xffd

rabbitmq/certs/server_*_certificate.pem: server-certificate
	cp -vf tls-gen/basic/result/ca_certificate.pem producer
	cp -vf tls-gen/basic/result/client*.* producer
	cp -vf tls-gen/basic/result/ca_certificate.pem consumer
	cp -vf tls-gen/basic/result/client*.* consumer
	cp -vf tls-gen/basic/result/ca_certificate.pem rmq/certs
	cp -vf tls-gen/basic/result/server_*_certificate.pem rmq/certs
	cp -vf tls-gen/basic/result/server_*_key.pem rmq/certs

tls-gen/basic/result/server_*_certificate.pem:
	cd tls-gen/basic && $(MAKE) CN=*

server-certificate-rabbitmq: rabbitmq/certs/server_*_certificate.pem
server-certificate: tls-gen/basic/result/server_*_certificate.pem
certs: server-certificate server-certificate-rabbitmq 
