const main = async () => {
    const waveContractFactory = await hre.ethers.getContractFactory("Wave");
    //compile contract and generate the necessary files we need to work with our contract under the artifacts directory
    const waveContract = await waveContractFactory.deploy();
    // create a local Ethereum network for us, but just for this contract
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
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