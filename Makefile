
# Contract folders
UNSAFE_BANK = ./unsafe_bank
BANK_EXPLOIT = ./bank_exploit

# Python script folders
EXPLOIT_BANK = ./exploit_bank
POPULATE_BANK = ./populate_bank

DEPLOY_FOLDER = deploy

UNSAFE_CONTRACT_NAME := UnsafeBankContract
UNSAFE_CONTRACT_ADDRESS_FILE := $(UNSAFE_BANK)/$(DEPLOY_FOLDER)/$(UNSAFE_CONTRACT_NAME).address

ATTACK_CONTRACT_NAME := BankExploitContract
ATTACK_CONTRACT_ADDRESS_FILE := $(BANK_EXPLOIT)/$(DEPLOY_FOLDER)/$(ATTACK_CONTRACT_NAME).address

GANACHE_URL := http://localhost:7545
GANACHE_NETWORK_ID := 5777

.PHONY: build-environment
build-environment:
	docker-compose up -d
	make build-populate
	make deploy

.PHONY: deploy
deploy: deploy-unsafe-bank deploy-bank-attack

.PHONY: deploy-unsafe-bank
deploy-unsafe-bank:
	@echo "Desplegando contrato $(UNSAFE_CONTRACT_NAME) en Ganache..."
	make -C $(UNSAFE_BANK) deploy

.PHONY: deploy-bank-attack
deploy-bank-attack:
	@echo "Desplegando contrato $(ATTACK_CONTRACT_NAME) en Ganache..."
	make -C $(BANK_EXPLOIT) deploy UNSAFE_CONTRACT_ADDRESS=$$(cat $(UNSAFE_CONTRACT_ADDRESS_FILE))

.PHONY: build-populate
build-populate:
	@echo "Compiling populate image..."
	make -C $(POPULATE_BANK) build

.PHONY: populate
populate:
	@echo "Compiling contract $(UNSAFE_CONTRACT_NAME)..."
	make -C $(POPULATE_BANK) run CONTRACT_ADDRESS=$$(cat $(UNSAFE_CONTRACT_ADDRESS_FILE))

.PHONY: build-exploit
build-exploit:
	@echo "Compiling exploit image..."
	make -C $(EXPLOIT_BANK) build

.PHONY: populate
exploit:
	@echo "Exploiting contract $(UNSAFE_CONTRACT_NAME)..."
	make -C $(EXPLOIT_BANK) run CONTRACT_ADDRESS=$$(cat $(ATTACK_CONTRACT_ADDRESS_FILE))