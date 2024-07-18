// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity 0.8.19;

contract Array{
 struct User{
    uint amount;
    uint reward;
 }

mapping (address=> User) public users;

function updateUser(uint amount) public {
    User memory user=users[msg.sender];
    user.reward=amount;
} 

function fikUpdateUser(uint amount) public {
    User storage user=users[msg.sender];
    user.reward=amount;
} 
}

contract ContractTest is Test {
Array array;

constructor (){
    array= new Array();
}
function test_DataLocation() public{

 array.updateUser(100);
(uint amount, uint reward)=array.users(address(this));
console.log(reward );
 array.fikUpdateUser(100);
(uint _amount, uint _reward)=array.users(address(this));
console.log( _reward);
}
}