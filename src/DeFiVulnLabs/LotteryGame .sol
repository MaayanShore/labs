// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity 0.8.19;
contract LotteryGame{
uint public prize=1000;
address public winner;
address public owner=msg.sender;
modifier safeCheck(){
if(msg.sender==referee()){
_;
}
else
  {
    getWinner();
  }

}

function referee() public view returns(address user) {
 assembly{
    user:=sload(2)
    
 }
}
function pickWinner(address random) public safeCheck(){
  
   assembly{
    sstore(1,random)
 }

}

function  getWinner() public view returns(address){
console.log("winner: " , winner );
 return winner; 
}

}

contract contractTest is Test{
address alice=vm.addr(1);
address bob=vm.addr(2);

LotteryGame lotteryGame= new LotteryGame();
function test_lotteryGame() public{
 console.log("alice: " , alice);
 console.log("bob: " , bob);
vm.startPrank(alice);
lotteryGame.pickWinner(address(alice));

vm.stopPrank();
lotteryGame.pickWinner(address(bob));
lotteryGame.getWinner();
}}

 