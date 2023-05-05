# Configuración del contrato
CONTRACT_NAME := UnsafeBankContract
CONTRACT_FILE := $(CONTRACT_NAME).sol
DEPLOY_FOLDER := ./deploy
CONTRACT_ADDRESS_FILE := $(DEPLOY_FOLDER)/$(CONTRACT_NAME).address

# Configuración de la conexión con Ganache
GANACHE_URL := http://localhost:8545
GANACHE_NETWORK_ID := 5777

# Compilar el contrato
.PHONY: compile
compile:
	@echo "Compilando contrato $(CONTRACT_NAME)..."
	truffle compile
	@echo "Contrato compilado."

# Desplegar el contrato en Ganache
.PHONY: deploy
deploy:
	@echo "Deploying contract $(CONTRACT_NAME) in Ganache..."
	truffle migrate --network ganache
	make get-contract-address
	
.PHONY: get-contract-address
get-contract-address:
	mkdir -p $(DEPLOY_FOLDER)
	echo $$(truffle networks --network ganache | grep UnsafeBankContract | awk '{print $$2}') > $(CONTRACT_ADDRESS_FILE)
	@echo "Contract deployed in $$(cat $(CONTRACT_ADDRESS_FILE))."


