// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves; // state variable
    mapping(address => uint256) waveCountsMap; // creates a namespace in which all possible keys exist, and values are initialized to 0/false
    address[] waversAddresses; // creates dynamically sized array that will store addresses of wavers (as with mapping it's not possible to iterate the keys or find out how many keys exist, because they all exist.) to keep track of number of wavers and find out which one of them has a highest count of waves


    constructor() {
        console.log("Gm frens");
    }

    function wave() public {
        waveCountsMap[msg.sender] += 1;
        waversAddresses.push(msg.sender);
        totalWaves += 1;
        console.log("%s has waved %d times!", msg.sender, waveCountsMap[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        uint256 waversCount;
        uint256 highestWavesCount;
        uint256 count;
        waversCount = waversAddresses.length;


        // Check for the highest waves count
        for (uint i = 0; i < waversCount; i++) {
            count = waveCountsMap[waversAddresses[i]];

            if (count > highestWavesCount) {
                highestWavesCount = count;
            }
        }

        console.log("We have %d total waves and %d total wavers!", totalWaves, waversCount);
        console.log("Highest wavers with %d waves:", highestWavesCount);

        // Log addresses with the highest waves count
        for (uint i = 0; i < waversCount; i++) {
            count = waveCountsMap[waversAddresses[i]];

             if (count == highestWavesCount) {
                console.log("%s", waversAddresses[i]);
            }
        }

        return totalWaves;
    }
}