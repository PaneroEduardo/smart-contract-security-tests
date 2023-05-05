
# Configuración de las rutas
UNSAFE_BANK = ./unsafe_bank
POPULATE_BANK = ./populate_bank

DEPLOY_FOLDER = deploy
# Configuración del contrato
CONTRACT_NAME := UnsafeBankContract
CONTRACT_FILE := $(CONTRACT_NAME).sol
CONTRACT_ADDRESS_FILE := $(UNSAFE_BANK)/$(DEPLOY_FOLDER)/$(CONTRACT_NAME).address
CONTRACT_ABI_FILE := $(CONTRACT_NAME).abi

# Configuración de la conexión con Ganache
GANACHE_URL := http://localhost:7545
GANACHE_NETWORK_ID := 5777



# Compilar el contrato
.PHONY: compile
populate:
	@echo "Compiling contract $(CONTRACT_NAME)..."
	make -C $(POPULATE_BANK) run CONTRACT_ADDRESS=$$(cat $(CONTRACT_ADDRESS_FILE))

# Desplegar el contrato en Ganache
.PHONY: deploy
deploy:
	@echo "Desplegando contrato $(CONTRACT_NAME) en Ganache..."
	make -C $(UNSAFE_BANK) deploy