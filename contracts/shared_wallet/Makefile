# Configuración del contrato
CONTRACT_NAME := SharedWallet
CONTRACT_FILE := $(CONTRACT_NAME).sol

DEPLOY_FOLDER := ./deploy
BUILD_FOLDER := ./build

CONTRACT_ADDRESS_FILE := $(DEPLOY_FOLDER)/$(CONTRACT_NAME).address

# Configuración de la conexión con Ganache
GANACHE_URL := http://localhost:8545
GANACHE_NETWORK_ID := 5777

.PHONY: compile
compile:
	@echo "Compilando contrato $(CONTRACT_NAME)..."
	truffle compile
	@echo "Contrato compilado."

.PHONY: deploy
deploy:
	@echo "Deploying contract $(CONTRACT_NAME) in Ganache..."
	mkdir -p $(DEPLOY_FOLDER)
	truffle migrate --network ganache
	make get-contract-address
	
.PHONY: get-contract-address
get-contract-address:
	echo $$(truffle networks --network ganache | grep $(CONTRACT_NAME) | awk '{print $$2}') > $(CONTRACT_ADDRESS_FILE)
	@echo "Contract deployed in $$(cat $(CONTRACT_ADDRESS_FILE))."

.PHONE: down
down:
	rm -rf $(DEPLOY_FOLDER)
	rm -rf $(BUILD_FOLDER)


