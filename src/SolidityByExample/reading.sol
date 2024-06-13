// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract SimpleStorage {
 
 uint public num;

 function set(uint n) public{
   num=n;
 }
function get() public view returns(uint256){
    return num;    
}
}
