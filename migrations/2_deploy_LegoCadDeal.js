const LegoCadDeal = artifacts.require('../contracts/LegoCadDeal.sol');

module.exports = deployer => {
    deployer.deploy(LegoCadDeal);
}