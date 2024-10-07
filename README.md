# Shopping list docker

This repository conatins all services contenerized with scripts to start up the application

## Step-by-step

1. Creates containers for a service

```shell
docker compose create
```

2. Start the databases

```shell
docker start keycloak-db shopping-list-db
```

3. Wait for database initializtion

4. Start keycloak service

```shell
docker start keycloak-web
```