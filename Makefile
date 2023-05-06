
# Folders
SCRIPTS_FOLDER := scripts
CONTRACTS_FOLDER := contracts
DEPLOY_FOLDER := deploy


# Contract folders
SHARED_WALLET := ./$(CONTRACTS_FOLDER)/shared_wallet
SHARED_WALLET_EXPLOIT := ./$(CONTRACTS_FOLDER)/shared_wallet_exploit

# Python script folders
ATTACK_SHARED_WALLET := ./$(SCRIPTS_FOLDER)/attack_shared_wallet
POPULATE_SHARED_WALLET := ./$(SCRIPTS_FOLDER)/populate_shared_wallet

SHARED_WALLET_CONTRACT_NAME := SharedWallet
SHARED_WALLET_CONTRACT_ADDRESS_FILE := $(SHARED_WALLET)/$(DEPLOY_FOLDER)/$(SHARED_WALLET_CONTRACT_NAME).address

SHARED_WALLET_EXPLOIT_CONTRACT_NAME := Exploit
SHARED_WALLET_EXPLOIT_OWNER_NAME := Account
SHARED_WALLET_EXPLOIT_ADDRESS_FILE := $(SHARED_WALLET_EXPLOIT)/$(DEPLOY_FOLDER)/$(SHARED_WALLET_EXPLOIT_CONTRACT_NAME).address
SHARED_WALLET_EXPLOIT_OWNER_FILE := $(SHARED_WALLET_EXPLOIT)/$(DEPLOY_FOLDER)/$(SHARED_WALLET_EXPLOIT_OWNER_NAME).address

GANACHE_URL := http://localhost:7545
GANACHE_NETWORK_ID := 5777

.PHONY: build-environment
build-environment:
	docker-compose up -d
	make build-populate
	make build-attack
	make deploy

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

.PHONY: build-populate
build-populate:
	@echo "Compiling populate image in $(POPULATE_SHARED_WALLET)"
	make -C $(POPULATE_SHARED_WALLET) build

.PHONY: populate
populate:
	@echo "Compiling contract $(SHARED_WALLET_CONTRACT_NAME)..."
	make -C $(POPULATE_SHARED_WALLET) run CONTRACT_ADDRESS=$$(cat $(SHARED_WALLET_CONTRACT_ADDRESS_FILE))

.PHONY: build-attack
build-attack:
	@echo "Compiling exploit image..."
	make -C $(ATTACK_SHARED_WALLET) build

.PHONY: attack
attack:
	@echo "A contract $(SHARED_WALLET_CONTRACT_NAME)... $$(cat $(SHARED_WALLET_EXPLOIT_OWNER_FILE))"
	make -C $(ATTACK_SHARED_WALLET) run CONTRACT_ADDRESS=$$(cat $(SHARED_WALLET_EXPLOIT_ADDRESS_FILE)) OWNER=$$(cat $(SHARED_WALLET_EXPLOIT_OWNER_FILE))

.PHONY: down
down:
	make -C $(SHARED_WALLET) down
	make -C $(SHARED_WALLET_EXPLOIT) down
	make -C $(POPULATE_SHARED_WALLET) down
	make -C $(ATTACK_SHARED_WALLET) down
	docker-compose down
