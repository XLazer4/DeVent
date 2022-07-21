//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Wave {
    uint256 prizeAmount = 0.0001 ether;
    mapping(address => uint256) public lastWavedAt;
     // to generate random number
    uint256 private seed;

    struct SWave {
        address waver;
        string message;
        uint256 timestamp;
    }

    event NewWave(SWave newWave);
    SWave[] totalWaves;

    constructor() payable {
        console.log("PEW PEW \n");
        //block.difficulty = how hard the block is to mine based on the trx on the block
        // setting initial seed 
        seed = (block.timestamp + block.difficulty) %100;
    }

    function sendPrize() private {
        require(
            prizeAmount <= address(this).balance,
            "No Money to withdraw."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw.");
    }

    function checkLastWaveByAddress() private {
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Pls wait 30 seconds before waving again."
        );

        lastWavedAt[msg.sender] = block.timestamp;
    }

    function wave(string memory _message) public{
        checkLastWaveByAddress();

        SWave memory createdWave = SWave(msg.sender, _message, block.timestamp);
        totalWaves.push(createdWave);

        // Generating new seed for the next user
        seed = (block.difficulty + block.timestamp + seed) %100;
        console.log("Random # generated: %d", seed);

        //Giving it 50% chance
        if(seed <= 50) {
            console.log("%s won!", msg.sender);
            //sendPrize();
        }
        emit NewWave(createdWave);

    }

    function getTotalWaves() public view returns (SWave[] memory) {
        return totalWaves;
    }

}
