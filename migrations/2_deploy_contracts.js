/*const NotaryPOE = artifacts.require("NotaryPOE.sol");

module.exports = function(deployer) {
  deployer.deploy(NotaryPOE);
};*/


const SupplyChain = artifacts.require("SupplyChainUpd1.sol");
const SupplyChainProxy = artifacts.require("SupplyChainContractProxy.sol");

module.exports = function(deployer) {
  //contract address: 0x79e4478b5f5B679f7509108bba48ED3b51437B98
  deployer.deploy(SupplyChain);
  
  //contract address: 0x457A9024C13bcD0bD492B8E0d706782Ba0aB21E4
  deployer.deploy(SupplyChainProxy);
};


/*const SupplyChain = artifacts.require("SupplyChainUpd1.sol");
module.exports = function(deployer) {
	
  	//contract address: 0xFAc481f504D54DbDdF21D0ED0aD63bcB2620ED3E
	deployer.deploy(SupplyChain);
};*/
