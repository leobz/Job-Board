## Docker compose backward compatibility to older versions
## More info: https://docs.docker.com/compose/#compose-v2-and-the-new-docker-compose-command
define DOCKER_COMPOSE
	@if which docker-compose  >/dev/null ; then docker-compose  $1; \
	else docker compose $1; fi;
endef

default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: dev
dev: #Run app local and db in container
	$(call DOCKER_COMPOSE, -f docker-compose.yml up -d)
	sh start_app.sh

.PHONY: stop
stop: # Terminates the execution of all containers
	$(call DOCKER_COMPOSE, down --remove-orphans)

.PHONY: clean
clean: # Terminates the execution of all containers + delete volumes
	$(call DOCKER_COMPOSE, -v down --remove-orphans)
	rm -r db-data/*
