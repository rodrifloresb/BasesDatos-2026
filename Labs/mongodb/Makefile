.PHONY: up stop clean shell logs

# Levanta el contenedor de MySQL
up:
	sudo docker run --name mongo-labs \
	-d \
	-p 127.0.0.1:27017:27017 \
	-e GLIBC_TUNABLES=glibc.pthread.rseq=1 \
	mongo:9

# Inicia el contenedor
start:
	docker start mongo-labs

# Detiene el contenedor
stop:
	docker stop mongo-labs

# Detiene y elimina el contenedor por completo
clean:
	docker stop mongo-labs || true
	docker rm mongo-labs || true

# Conecta a la base de datos con la consola interactiva
shell:
	sudo docker exec -it mongo-labs mongosh


# Muestra los logs en tiempo real
logs:
	docker logs -f mongo-labs
