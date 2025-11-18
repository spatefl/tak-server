#!/bin/bash

if [ -z "$DOCKER_COMPOSE" ]; then
	if docker compose version >/dev/null 2>&1; then
		DOCKER_COMPOSE="docker compose"
	elif command -v docker-compose >/dev/null 2>&1; then
		DOCKER_COMPOSE="docker-compose"
	else
		echo "Unable to find Docker Compose. Install it and rerun cleanup."
		exit 1
	fi
fi
echo "Docker compose command set to: $DOCKER_COMPOSE"

$DOCKER_COMPOSE down
docker volume rm --force tak-server_db_data
rm -rf tak
rm -rf /tmp/takserver

# Comment me out to save yourself rebuilding........
docker image rm tak-server-db --force
docker image rm tak-server-tak --force
