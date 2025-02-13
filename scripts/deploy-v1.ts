import { ethers, upgrades } from "hardhat";

async function main() {
  const VotingV1 = await ethers.getContractFactory("VotingV1");
  // Deploy the proxy and call initialize() in the process
  const voting = await upgrades.deployProxy(VotingV1, [], { initializer: "initialize" });
  await voting.deployed();
  console.log("Voting V1 deployed at:", voting.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
