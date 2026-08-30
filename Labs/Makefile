.PHONY: up stop clean shell logs

# Levanta el contenedor de MySQL
up:
	docker run -d \
		--name database \
		-e MYSQL_ROOT_PASSWORD=pass \
		-e MYSQL_DATABASE=demo \
		-p 3306:3306 \
		mysql:latest

# Detiene el contenedor
stop:
	docker stop database

# Detiene y elimina el contenedor por completo
clean:
	docker stop database || true
	docker rm database || true

# Conecta a la base de datos con la consola interactiva
shell:
	docker exec -it database mysql -u root -p

# Muestra los logs en tiempo real
logs:
	docker logs -f database

