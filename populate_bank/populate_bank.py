from web3 import Web3
import random

ganache_url = "http://localhost:7545" 
web3 = Web3(Web3.HTTPProvider(ganache_url))

accounts = web3.eth.accounts
print("Cuentas disponibles:", accounts)

contract_address = "0x1234567890123456789012345678901234567890"
abi = [
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [],
        "name": "deposit",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    }
]

contract = web3.eth.contract(address=contract_address, abi=abi)

for account in accounts:
    value = web3.toWei(random.uniform(5, 10), "ether")

    tx_hash = contract.functions.deposit().transact({
        "from": account,
        "value": value
    })

    tx_receipt = web3.eth.waitForTransactionReceipt(tx_hash)
