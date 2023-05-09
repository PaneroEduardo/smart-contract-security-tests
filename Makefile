
# Folders
SCRIPTS_FOLDER := scripts
CONTRACTS_FOLDER := contracts
DEPLOY_FOLDER := deploy
TOOLS_FOLDER := folder


# Contract folders
SHARED_WALLET := $(CONTRACTS_FOLDER)/shared_wallet
SHARED_WALLET_EXPLOIT := $(CONTRACTS_FOLDER)/shared_wallet_exploit

# Python script folders
ATTACK_SHARED_WALLET := ./$(SCRIPTS_FOLDER)/attack_shared_wallet
POPULATE_SHARED_WALLET := ./$(SCRIPTS_FOLDER)/populate_shared_wallet

# Analysis makefiles folders
VULNERABILITIES_SCAN:= ./$(TOOLS_FOLDER)/analysis
TRANSACTION_MONITOR:= ./$(TOOLS_FOLDER)/monitor

# Docker configuration
DOCKER_NETWORK:= smart-contract-security-tests_default

SHARED_WALLET_CONTRACT_NAME := SharedWallet
SHARED_WALLET_CONTRACT_ADDRESS_FILE := $(SHARED_WALLET)/$(DEPLOY_FOLDER)/$(SHARED_WALLET_CONTRACT_NAME).address

SHARED_WALLET_EXPLOIT_CONTRACT_NAME := Exploit
SHARED_WALLET_EXPLOIT_OWNER_NAME := Account
SHARED_WALLET_EXPLOIT_ADDRESS_FILE := $(SHARED_WALLET_EXPLOIT)/$(DEPLOY_FOLDER)/$(SHARED_WALLET_EXPLOIT_CONTRACT_NAME).address
SHARED_WALLET_EXPLOIT_OWNER_FILE := $(SHARED_WALLET_EXPLOIT)/$(DEPLOY_FOLDER)/$(SHARED_WALLET_EXPLOIT_OWNER_NAME).address

GANACHE_URL := ganache-cli:8545
GANACHE_NETWORK_ID := 5777

.PHONY: up
up:
	docker-compose up --build -d
	make build-populate
	make build-attack
	make deploy
	make -C $(VULNERABILITIES_SCAN) up

# Deploy contracts
.PHONY: deploy
deploy: deploy-shared-wallet deploy-shared-wallet-exploit

.PHONY: deploy-shared-wallet
deploy-shared-wallet:
	@echo "Desplegando contrato $(SHARED_WALLET_CONTRACT_NAME) en Ganache..."
	make -C $(SHARED_WALLET) deploy

.PHONY: deploy-shared-wallet-exploit
deploy-shared-wallet-exploit:
	@echo "Desplegando contrato $(SHARED_WALLET_EXPLOIT_CONTRACT_NAME) en Ganache... $(SHARED_WALLET_CONTRACT_ADDRESS_FILE)"
	make -C $(SHARED_WALLET_EXPLOIT) deploy SHARED_WALLET_CONTRACT_ADDRESS=$$(cat $(SHARED_WALLET_CONTRACT_ADDRESS_FILE))


# Populate script of SharedWallet contract
.PHONY: build-populate
build-populate:
	@echo "Compiling populate image in $(POPULATE_SHARED_WALLET)"
	make -C $(POPULATE_SHARED_WALLET) build

.PHONY: populate
populate:
	@echo "Compiling contract $(SHARED_WALLET_CONTRACT_NAME)..."
	make -C $(POPULATE_SHARED_WALLET) run CONTRACT_ADDRESS=$$(cat $(SHARED_WALLET_CONTRACT_ADDRESS_FILE))


# Attack script to SharedWallet contract
.PHONY: build-attack
build-attack:
	@echo "Compiling exploit image..."
	make -C $(ATTACK_SHARED_WALLET) build

.PHONY: attack
attack:
	@echo "A contract $(SHARED_WALLET_CONTRACT_NAME)... $$(cat $(SHARED_WALLET_EXPLOIT_OWNER_FILE))"
	make -C $(ATTACK_SHARED_WALLET) run CONTRACT_ADDRESS=$$(cat $(SHARED_WALLET_EXPLOIT_ADDRESS_FILE)) OWNER=$$(cat $(SHARED_WALLET_EXPLOIT_OWNER_FILE))

# Scan vulnerabilities command
.PHONY: scan-vulnerabilities-by-address
scan-vulnerabilities-by-address:
	make -C $(VULNERABILITIES_SCAN) run-by-address NETWORK=$(DOCKER_NETWORK)  URL=$(GANACHE_URL) CONTRACT_ADDRESS=$$(cat $(SHARED_WALLET_CONTRACT_ADDRESS_FILE))

.PHONY: scan-vulnerabilities-by-file
scan-vulnerabilities-by-file:
	make -C $(VULNERABILITIES_SCAN) run-by-file NETWORK=$(DOCKER_NETWORK) URL=$(GANACHE_URL) FOLDER=$$(PWD)/$(SHARED_WALLET)/contracts FILE=$(SHARED_WALLET_CONTRACT_NAME).sol



.PHONY: down
down:
	make -C $(SHARED_WALLET) down
	make -C $(SHARED_WALLET_EXPLOIT) down
	make -C $(POPULATE_SHARED_WALLET) down
	make -C $(ATTACK_SHARED_WALLET) down
	docker-compose down
	make -C $(VULNERABILITIES_SCAN) down

