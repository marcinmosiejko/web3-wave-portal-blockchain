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

    // payable keyword allows the contract to pay (send) money to addresses
    constructor() payable { 
        console.log("Gm frens");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        // Check if contract has more money then prizeAmount, if not it will quit the function
        require(
        prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has."
        );
        // Send prize money to the waver
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
  
    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}