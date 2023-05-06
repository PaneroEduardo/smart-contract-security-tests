var SharedWallet = artifacts.require("SharedWallet");

module.exports = function(deployer, network, accounts) {
  const account = accounts[0];
  deployer.deploy(SharedWallet, {from: account})
};