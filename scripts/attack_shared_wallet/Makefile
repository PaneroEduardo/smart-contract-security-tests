
# Configuración de la conexión con Ganache
GANACHE_URL := http://ganache-cli:8545
GANACHE_NETWORK_ID := 5777

#
DOCKER_IMAGE:=attack_shared_wallet_script

# Compilar el contrato
.PHONY: build
build:
	@echo "Generate image for exploit bank script"
	docker build . -t $(DOCKER_IMAGE)
	@echo "Image for exploit bank script generated"

# Desplegar el contrato en Ganache
.PHONY: run
run:
	@echo "Running the exploit bank script for the contract address $(CONTRACT_ADDRESS) in $(GANACHE_URL) $(OWNER)"
	docker run --rm --network smart-contract-security-tests_default $(DOCKER_IMAGE)  --contract-address $(CONTRACT_ADDRESS) --owner $(OWNER) --url $(GANACHE_URL)
	@echo "The exploit bank finished"

.PHONE: down
down:
	docker rmi --force $(DOCKER_IMAGE)



