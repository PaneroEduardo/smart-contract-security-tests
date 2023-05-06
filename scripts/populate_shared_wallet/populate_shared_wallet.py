from web3 import Web3
import random
import click

abi = [
    {
        "inputs": [],
        "name": "deposit",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function",
        "payable": True
    },
]

def get_web3(url):
    return Web3(Web3.HTTPProvider(url))

def populate(contract_address, url):
    web3 = get_web3(url)
    contract = web3.eth.contract(address=contract_address, abi=abi)
    accounts = web3.eth.accounts

    for account in accounts:
        value = web3.toWei(random.uniform(5, 10), "ether")

        tx_hash = contract.functions.deposit().transact({
            "from": account,
            "value": value
        })

        web3.eth.waitForTransactionReceipt(tx_hash)
        print("The account {0} sent {1} ETH.".format(account, web3.fromWei(value, "ether")))


@click.command()
@click.option('--contract-address', prompt='Write the contract address', help='Contract address to populate')
@click.option('--url', prompt=False, help='Url of the blockchain', default="http://localhost:7545")
def populate_contract(contract_address, url):
    """Script to populate the contract 'SharedWallet' with a large amount of Ether"""
    populate(contract_address, url)

if __name__ == '__main__':
    populate_contract()