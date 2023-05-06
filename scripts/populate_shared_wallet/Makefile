# Ganache configuration Docker
GANACHE_URL := http://ganache-cli:8545
GANACHE_NETWORK_ID := 5777

DOCKER_IMAGE:=populate_shared_wallet_script

.PHONY: build
build:
	@echo "Generate image for populate shared wallet script"
	docker build . -t $(DOCKER_IMAGE)
	@echo "Image for populate shared wallet script generated"

.PHONY: run
run:
	@echo "Running the populate shared wallet script for the contract address $(CONTRACT_ADDRESS) in $(GANACHE_URL)"
	docker run --rm --network smart-contract-security-tests_default $(DOCKER_IMAGE) --contract-address $(CONTRACT_ADDRESS) --url $(GANACHE_URL)
	@echo "The populate shared wallet script finished"

.PHONE: down
down:
	docker rmi --force $(DOCKER_IMAGE)



