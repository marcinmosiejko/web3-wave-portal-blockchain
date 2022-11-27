// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves; // state variable
    uint256 private seed; // to generate random number

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

    // To store the address with the last time the user waved at us
    mapping(address => uint256) public lastWavedAt;

    // payable keyword allows the contract to pay (send) money to addresses
    constructor() payable { 
        console.log("Gm frens");

        // Set the initial seed to generate random number
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        // We make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored for a 15 min cooldown
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        // Update the current timestamp we have for the user
        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        // Generate a new seed for the next user that sends a wave
        seed = (block.difficulty + block.timestamp + seed) % 100;

        // Give a 50% chance that the user wins the prize
        if (seed < 50) {
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
        
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
  
    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}