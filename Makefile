# Configuración del contrato
CONTRACT_NAME := UnsafeBankContract
CONTRACT_FILE := $(CONTRACT_NAME).sol
CONTRACT_ADDRESS_FILE := $(CONTRACT_NAME).address
CONTRACT_ABI_FILE := $(CONTRACT_NAME).abi

# Configuración de la conexión con Ganache
GANACHE_URL := http://localhost:7545
GANACHE_NETWORK_ID := 5777

# Compilar el contrato
.PHONY: compile
compile:
	@echo "Compilando contrato $(CONTRACT_NAME)..."
	truffle compile --contracts_build_directory unsafe-bank/build --config unsafe-bank/truffle-config.js
	@echo "Contrato compilado."

# Desplegar el contrato en Ganache
.PHONY: deploy
deploy:
	@echo "Desplegando contrato $(CONTRACT_NAME) en Ganache..."
	truffle migrate --reset --config unsafe-bank/truffle-config.js --network ganache
#	echo $$(truffle networks | awk 'f;/^  Address: /{print $$2;f=1}' | tail -n 1) > unsafe-bank/$(CONTRACT_ADDRESS_FILE)
#	truffle networks | awk 'f;/^  ABI: /{print $$2;f=1}' | tail -n 1 > unsafe-bank/$(CONTRACT_ABI_FILE)
# 	@echo "Contrato desplegado en dirección $$(cat unsafe-bank/$(CONTRACT_ADDRESS_FILE))."

# Ejecutar el script de Python
.PHONY: run
run:
	@echo "Ejecutando script de Python..."
	python3 script.py $(GANACHE_URL) $$(cat bank-unsafe/$(CONTRACT_ADDRESS_FILE)) bank-unsafe/$(CONTRACT_ABI_FILE)
