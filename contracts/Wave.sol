//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Wave {
    uint256 totalWaves;

    constructor() {
        console.log("pew pew");
    }

    function wave() public {
        total += 1;
        console.log("%s has waved", msg.sender);
    }

    function getTotalWaves() public {
        console.log("%d people waved", total);
        return total;
    }
}
