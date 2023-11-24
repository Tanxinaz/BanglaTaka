const { ethers } = require("hardhat");

async function main() {
  const ElevateX = await ethers.getContractFactory("ElevateX");
  const bt = await ElevateX.deploy(
    "ElevateX",
    "BDT",
    18,
    //Add the ether fee after regulatory approval and deployment
    ethers.utils.parseEther("1000"),
    "TBA"
  );
  await bt.deployed();
  console.log("ElevateX deployed to:", bt.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
