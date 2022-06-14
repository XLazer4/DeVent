//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Wave {
    uint256 total;
    mapping (address => uint) balance;

    constructor() {
        console.log("PEW PEW \n");
    }

    function wave() public{
        total += 1;
        console.log("%s has waved", msg.sender);
        balance[msg.sender]++;
        console.log("Number of waves %d \n",balance[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("%d people waved \n", total);
        return total;
    }
}
