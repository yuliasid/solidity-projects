// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Party {
    uint256 public depositAmount;
    address public owner;  // Owner of the contract
    mapping(address => bool) public rsvpList;
    address[] public attendeesArray;  // Array to store attendees' addresses
    uint public attendeesCount;  // Count of attendees

    constructor(uint256 _depositAmount) {
        depositAmount = _depositAmount;
        owner = msg.sender;  // Setting the contract deployer as the owner
    }

    function rsvp() external payable {
        require(!rsvpList[msg.sender], "Address already RSVP'd");
        require(msg.value == depositAmount, "Incorrect deposit amount");
        rsvpList[msg.sender] = true;
        attendeesArray.push(msg.sender);  // Add sender to attendees array
        attendeesCount++;  // Increment the count of attendees
    }

    function payBill(address venue, uint amount) external {
        require(msg.sender == owner, "Not authorized");
        require(address(this).balance >= amount, "Insufficient funds to pay the bill");
        payable(venue).transfer(amount);

        uint share = (address(this).balance) / attendeesCount;
        for (uint i = 0; i < attendeesArray.length; i++) {
            payable(attendeesArray[i]).transfer(share);
        }
        attendeesCount = 0;
        delete attendeesArray;  // Clear the attendees array for the next event
    }
}
