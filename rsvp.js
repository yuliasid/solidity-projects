//This challenge is all about creating a group with your friends to split a shared expense.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Party {
// Declaration of the state variable to store the deposit amount
    uint256 public depositAmount;

constructor(uint256 _depositAmount) {
    // Assigning the passed value to the state variable
    depositAmount = _depositAmount;
}
// Data structure to track RSVPs
mapping(address => bool) public rsvpList;

// RSVP function
function rsvp() external payable {
    require(!rsvpList[msg.sender], "Address already RSVP'd");
    require(msg.value == depositAmount, "Incorrect deposit amount");
    rsvpList[msg.sender] = true;

}
}