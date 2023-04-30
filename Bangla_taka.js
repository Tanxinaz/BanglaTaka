const { ethers } = require("hardhat");

async function main() {
  const BanglaTaka = await ethers.getContractFactory("BanglaTaka");
  const bt = await BanglaTaka.deploy(
    "Bangla Taka",
    "BDT",
    18,
    //Add the ether fee after regulatory approval and deployment
    ethers.utils.parseEther("1000"),
    "TBA"
  );
  await bt.deployed();
  console.log("BanglaTaka deployed to:", bt.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
