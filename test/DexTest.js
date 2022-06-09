const { expect } = require("chai");
const { ethers } = require("hardhat");

/**
  *@dev setup constants - addresses for both tokens
  *
  * @dev setup myExchange variable to hold properties of contract after its deployed
  * 
  * @dev create beforeEach function to deploy contract before runnning tests
  * 
  * @dev destructures owner address from a list of accounts on the hardhat network node
  * 
  * @dev Deploys smart contract with ethers js 


*/

describe("Dex Testing", () => {
  const pancakeRouterAddress = "0x10ED43C718714eb63d5aA57B78B54704E256024E";
  const cakeTokenAddress = "0x0E09FaBB73Bd3Ade0a17ECC321fD13a19e81cE82";

  let dexterExchange;

  beforeEach("deploy dexterExchange contract", async () => {
    const accounts = await ethers.getSigners();
    owner = accounts[0];
    const DexterExchangeContract = await ethers.getContractFactory("DexterExchange");
    dexterExchange = await DexterExchangeContract.deploy(pancakeRouterAddress);
    await dexterExchange.deployed();
    console.log(`dexterExchange deployed at ${dexterExchange.address}`);
  });

  it("Should accept user's BNB and swap for Cake", async () => {
    const bnb_cake_swap_tx = await dexterExchange
      .connect(owner)
      .swapExactBNBForTokens(0, cakeTokenAddress, {
        value: ethers.utils.parseEther("500"),
      });
    console.log(bnb_cake_swap_tx);
  });
});
