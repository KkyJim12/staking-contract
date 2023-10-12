const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const Stake = await hre.ethers.getContractFactory("Stake");
  const stake = await Stake.deploy();

  await stake.deployed();

  console.log(`Deployed contract address is ${stake.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
