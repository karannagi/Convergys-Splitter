var Splitter = artifacts.require("./Splitter.sol");


module.exports = function(deployer) {
  deployer.deploy(Splitter,"0x914feab9c093134ce34d4d11eef8b5046e5840f4","0x874eb1c039cd9253fb88c26f9f17b66a2e9b747e","0xa1e745e6a5a2bd08e2b59563722d1545ddcb59d6");

};
