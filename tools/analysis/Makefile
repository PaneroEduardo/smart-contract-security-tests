
.PHONY: up
up:
	@echo "Build the vulnerabilities tools benckmark"
	docker pull mythril/myth
	make slither-up
	

.PHONY: mythril-run-by-address
mythril-run-by-address:
	@echo "Running a new vulnerabilities scan with the address $(CONTRACT_ADDRESS)"
	docker run -it  --network $(NETWORK) --name mythril mythril/myth analyze -a $(CONTRACT_ADDRESS) --rpc $(URL)

.PHONY: mythril-run-by-file
mythril-run-by-file:
	@echo "Running a new vulnerabilities scan with the file $(FILE)"
	docker run -it --network $(NETWORK) --name mythril --volume $(FOLDER):/contracts  mythril/myth analyze /contracts/$(FILE) -o json

.PHONY: slither-up
slither-up:
	@echo "Getting Slither from GitHub"
	sh slither-up.sh

	

.PHONY: slither-analysis
slither-analysis:
	@echo "Analysis the contract file with Securify 2.0"
	docker run --rm -i -v $(FOLDER):/home/slither/slither/contracts slither slither contracts/$(FILE)


.PHONY: down
down:
	@echo "Removing Mythril image" 
	docker rmi mythril/myth --force
	docker rmi slither --force
	rm -Rf slither

