// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/console.sol";

contract Stack {
    struct User {
        uint256 amount;
        uint256 startDate;
    }

    User public user;
    uint256 private rewards = 1000000;
    uint256 private balance = 0;
    mapping(address => User) public users;

    constructor() {}

    function setUser(uint256 amount) public {
        uint256 amountBefore = users[msg.sender].amount;
        User memory newUser = User(amount, block.timestamp);
        users[msg.sender] = newUser;
    }

    // // Function to get the values of the struct arguments
    // function getUser() public view returns (uint, uint ) {
    //     return (User.amount, User.startDate);
    // }
    function stack(uint256 amount) public {
        setUser(amount);

        balance = balance + amount;
    }
}
