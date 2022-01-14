SHELL = /bin/bash

.PHONY: list
list:
	@LC_ALL=C $(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

dev-up:
	@echo "Starting dev containers"
	docker-compose build --build-arg USER_ID=$(shell id -u) --build-arg GROUP_ID=$(shell id -g)
	docker-compose up -d --force-recreate --remove-orphans

dev-down:
	@echo "Stopping dev containers"
	docker-compose down

prod-up:
	@echo "Starting prod containers"
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml build --build-arg USER_ID=1000 --build-arg GROUP_ID=1000
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --force-recreate --remove-orphans

prod-down:
	@echo "Stopping prod containers"
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml down