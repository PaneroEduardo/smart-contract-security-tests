var UnsafeBankContract = artifacts.require("UnsafeBankContract");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(UnsafeBankContract);
};