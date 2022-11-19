const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal"); // compiles the contract
  const waveContract = await waveContractFactory.deploy(); // creates a local Ethereum network (gets destroyed at the end of the script) and deploys the contract
  await waveContract.deployed();
  console.log("Contract deployed to:", waveContract.address); // waveContract.address give the address of the deployed contract
};

const runMain = async () => {
  try {
    await main();
    process.exit(0); // exit Node process without error
  } catch (error) {
    console.log(error);
    process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
  }
  // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
};

runMain();
