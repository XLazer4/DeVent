//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Wave {
    uint256 total;
    mapping (address => uint) amount;
    uint256 private seed;
    // will be used to generate random number

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct SWave {
        address waver;
        string message;
        uint256 timestamp;
    }

    SWave[] waves;

    constructor() payable {
        console.log("PEW PEW \n");
        //block.difficulty = how hard the block is to mine based on the trx on the block
        seed = (block.timestamp + block.difficulty) %100;
        // setting initial seed 
    }

    function wave(string memory _message) public{
        total += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);
        waves.push(SWave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) %100;
        // Generating new seed for the next user
        console.log("Random # generated: %d", seed);

        amount[msg.sender]++;
        console.log("Number of waves %d \n",amount[msg.sender]);
        emit NewWave(msg.sender, block.timestamp, _message);

        //Giving it 50% chance
        if(seed <= 50) {
            console.log("%s won!", msg.sender);
            uint prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}(""); 
            // Sending Ether to the user
            require(success, "Failed to withdraw money");
            // knowing if the trx was successful or a failure
        }

    }

    function getallwaves() public view returns(SWave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("%d people waved \n", total);
        return total;
    }
}
