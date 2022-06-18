//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Wave {
    uint256 total;
    mapping (address => uint) balance;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct SWave {
        address waver;
        string message;
        uint256 timestamp;
    }

    SWave[] waves;

    constructor() {
        console.log("PEW PEW \n");
    }

    function wave(string memory _message) public{
        total += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);
        waves.push(SWave(msg.sender, _message, block.timestamp));
        balance[msg.sender]++;
        console.log("Number of waves %d \n",balance[msg.sender]);
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getallwaves() public view returns(SWave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("%d people waved \n", total);
        return total;
    }
}
