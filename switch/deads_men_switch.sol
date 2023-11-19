//smart contract that will transfer funds to a recipient after a period of inactivity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Switch {
    // State variables
    address payable public recipient;  // Address that will receive the funds
    address public owner;              // Owner of the contract, typically the one who deploys it
    uint256 public lastActivity;       // Timestamp of the last activity (ping or deployment)

    // Constructor: sets up initial state of the contract
    constructor(address payable _recipient) payable {
        recipient = _recipient;      // Set the recipient of the funds
        owner = msg.sender;          // Set the owner to the address deploying the contract
        lastActivity = block.timestamp; // Initialize lastActivity with the current time
    }

    // Withdraw function: allows the recipient to withdraw funds after 52 weeks of inactivity
    function withdraw() external {
        // Check if 52 weeks have passed since the last activity
        require(block.timestamp >= lastActivity + 52 weeks, "Cannot withdraw yet");

        // Transfer all contract's funds to the recipient
        recipient.transfer(address(this).balance);
    }

    // Ping function: called by the owner to reset the inactivity timer
    function ping() external {
        // Ensure that only the owner can call ping
        require(msg.sender == owner, "Only the owner can ping");

        // Update lastActivity to the current time
        lastActivity = block.timestamp;
    }
}
