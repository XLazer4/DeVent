const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    // adding wallet adderesses
    const waveContractFactory = await hre.ethers.getContractFactory("Wave");
    // compile contract and generate the necessary files we need to work with our contract under the artifacts directory
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther("0.1"),
    });
    // create a local Ethereum network for us, but just for this contract and sending ether to it
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
    await wavetx.wait(); // waiting for this function to be mined first then continuing

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );

    let wavecount;
    wavecount = await waveContract.getTotalWaves(); // no await wavecount.wait() here cuz its a view function and nothing is updated

    let allWaves = await waveContract.getallwaves();
    console.log(allWaves);
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