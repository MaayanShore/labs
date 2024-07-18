// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ViewAndPure {
uint x;

function addX(uint y) public view returns(uint){
 return x+y;
}

function add(uint y, uint i) public pure returns(uint){
 return y+i;
}
}



