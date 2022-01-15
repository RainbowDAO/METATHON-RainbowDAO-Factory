const DaoFactory = artifacts.require("DaoFactory");
const ERC20Factory = artifacts.require("ERC20Factory");

module.exports = function (deployer) {

  deployer.then(function() {
	  	return ERC20Factory.deployed();
	}).then(function(instance) {
      deployer.deploy(ERC20Factory,instance.address);
	})
};
