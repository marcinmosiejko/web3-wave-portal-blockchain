// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves; // state variable
   
    // When an event is emitted, it stores the arguments passed in transaction logs
    event NewWave(address indexed from, uint256 timestamp, string message);

    // Struct is a custom datatype, allows to customize what we want to hold inside it
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    // Array of Wave structs that lets us hold all the waves anyone ever sends
    Wave[] waves;

    constructor() {
        console.log("Gm frens");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
  
    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}