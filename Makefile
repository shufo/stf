install:
	@echo "Verify no other virtual machines are booting. \n\n"
	vagrant up
	docker-compose -f compose/local.yml -p stf up -d && make migrate

.PHONY: build
ifeq (build,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
build:
	docker-compose -f compose/local.yml -p stf build $(RUN_ARGS)

.PHONY: logs
ifeq (logs,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
logs:
	docker-compose -f compose/local.yml -p stf logs $(RUN_ARGS)

.PHONY: run
ifeq (run,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
run:
	docker-compose -f compose/local.yml -p stf run $(RUN_ARGS)

.PHONY: up
ifeq (up,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
up:
	docker-compose -f compose/local.yml -p stf up -d $(RUN_ARGS)

.PHONY: rm
ifeq (rm,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
rm:
	docker-compose -f compose/local.yml -p stf kill $(RUN_ARGS) && \
	docker-compose -f compose/local.yml -p stf rm -f $(RUN_ARGS)

ps:
	docker-compose -f compose/local.yml -p stf ps

.PHONY: restart
ifeq (restart,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
restart:
	docker-compose -f compose/local.yml -p stf kill $(RUN_ARGS) && \
	docker-compose -f compose/local.yml -p stf rm -f $(RUN_ARGS) && \
	docker-compose -f compose/local.yml -p stf up -d $(RUN_ARGS)

.PHONY: recreate
ifeq (recreate,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
rebuild:
	docker-compose -f compose/local.yml -p stf kill $(RUN_ARGS) && \
	docker-compose -f compose/local.yml -p stf rm -f $(RUN_ARGS) && \
	docker-compose -f compose/local.yml -p stf build $(RUN_ARGS) && \
	docker-compose -f compose/local.yml -p stf up -d $(RUN_ARGS)

.PHONY: attach
ifeq (attach,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
attach:
	docker exec -it stf_$(RUN_ARGS)_1 /bin/bash

migrate:
	docker-compose -f compose/local.yml -p stf run --rm StfApp stf migrate
	
