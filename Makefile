default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: dev
dev: #Run app local and db in container
	$(call DOCKER_COMPOSE, -f docker-compose-dev.yml up -d)
	sh start_app.sh

.PHONY: stop
stop: # Terminates the execution of all containers
	$(call DOCKER_COMPOSE, down --remove-orphans)

.PHONY: clean
clean: # Terminates the execution of all containers + delete volumes
	$(call DOCKER_COMPOSE, -v down --remove-orphans)
	rm -r db-data/*
