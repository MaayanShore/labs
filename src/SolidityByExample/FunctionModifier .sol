// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract FunctionModifier {

address public owner;
uint public x=10;
bool public locked;

constructor()
{
   owner=msg.sender;
}

modifier onlyOwner(){
    require(owner==msg.sender, "not owner");
    _;
}

modifier checkAddress(address adr){
    require(adr!=address(0), "not valid address");
    _;
}

function setAddress(address adr) public 
 onlyOwner()  
 checkAddress(adr)
 {
  owner=adr;
 }

modifier noReentrancy() {
 require(!locked,"you cant get in");
 locked=true;
 _;
 locked=false;

}

function decrement(uint i) public noReentrancy(){
  x-=i;

  if(i>1)
   decrement(i-1);
}

}