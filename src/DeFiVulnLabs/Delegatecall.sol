// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity 0.8.19;

contract Delagate{
address public owner=address(0xdeadbeef);
function pwn() public{
  owner=msg.sender;
}

}

contract Proxy{
 address public owner =address(0xdeadbeef);
 Delagate  dela;
 
 constructor (Delagate  delagateaddress){
    dela=delagateaddress;
 }

 fallback() external{
    (bool suc, )=address(dela).delegatecall(msg.data); 
    require(suc, "didnt work");
 }
}


contract contractTest is Test{
address alice;
Delagate del;
Proxy proxy;
function test_delagate() public{
alice=vm.addr(1);
del=new Delagate();
proxy=new Proxy(del);

console.log( proxy.owner());

vm.prank(alice);
address(proxy).call(abi.encodeWithSignature("pwn()"));
console.log(proxy.owner());
}


}