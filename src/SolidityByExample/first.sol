// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Counter{
 uint public count;

 function get() public view returns(uint){

    return count;
 }

function inc() public {

    count+=1;
}

function dic( ) public {
    count-=1;
}

}