
.PHONY: up
up:
	@echo "Getting Mythril image from hub.docker.com"
	docker pull mythril/myth

.PHONY: run-by-address
run-by-address:
	@echo "Running a new vulnerabilities scan with the address $(CONTRACT_ADDRESS)"
	docker run --rm -it  --network $(NETWORK) --name mythril mythril/myth analyze -a $(CONTRACT_ADDRESS) --rpc $(GANACHE_URL)

.PHONY: run-by-file
run-by-file:
	@echo "Running a new vulnerabilities scan with the file $(FILE)"
	docker run --rm -it --network $(NETWORK) --name mythril --volume $(FOLDER):/contracts  mythril/myth analyze /contracts/$(FILE) -o json

.PHONY: down
	@echo "Removing Mythril image"
	docker 
	docker rmi mythril/myth --force

