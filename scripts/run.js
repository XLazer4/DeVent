const main = async () => {
  // adding wallet adderesses
  const [owner, randomPerson] = await hre.ethers.getSigners();
  // compile contract and generate the necessary files we need to work with our contract under the artifacts directory
  const waveContractFactory = await hre.ethers.getContractFactory("Wave");
  // create a local Ethereum network for us, but just for this contract and sending ether to it
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther("0.1"),
  });
  await waveContract.deployed();

  console.log("Contract deployed to: %s", waveContract.address);
  console.log("Contract deployed by: %s \n", owner.address);

  //Get contract balance
  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address
  );
  console.log(
    "Contract Balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  // Manually calling functions
  let wavetx;
  wavetx = await waveContract.connect(randomPerson).wave("wassup bych");
  // waiting for this function to be mined first then continuing
  await wavetx.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log(
    "Contract balance:",
    hre.ethers.utils.formatEther(contractBalance)
  );

  let wavecount;
  // no await wavecount.wait() here cuz its a view function and nothing is updated
  wavecount = await waveContract.getTotalWaves();

  let allWaves = await waveContract.getallwaves();
  console.log(allWaves);
};

const runMain = async () => {
  try {
    await main();
    // exit Node process without error
    process.exit(0);
  } catch (error) {
    console.log(error);
    // exit Node process while indicating 'Uncaught Fatal Exception' error
    process.exit(1);
  }
};

runMain();
