> [!IMPORTANT] 
> [Instalar docker](https://docs.docker.com/desktop/setup/install/linux/)


## Instalar MySQL en un contendor Docker.

```bash
docker run -d \
  --name database \
  -e MYSQL_ROOT_PASSWORD=pass \
  -e MYSQL_DATABASE=demo \
  -p 3306:3306 \
  mysql:latest
```

## Acceder al contenedor.


```bash
docker exec -it database mysql -u root -p
```

> password : pass


> [!TIP]
> [Doc MySQL](https://dev.mysql.com/doc/refman/8.0/en/create-table.html)

