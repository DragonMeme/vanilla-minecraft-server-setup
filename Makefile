.ONESHELL:
SHELL := /bin/bash
RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

MCVERSION := $(firstword $(RUN_ARGS))

agree-eula:
	echo "eula=TRUE" > out/eula.txt

setup-env:
	./setup_mc_env.sh -mcv $(MCVERSION)

up:
	docker compose up

down:
	docker compose down

server: setup-env up