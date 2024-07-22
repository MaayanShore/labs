// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity ^0.8.7;
contract Dirtybytes{
 event a(uint[],uint);
 bytes s;

 constructor(){
  emit a(new uint[](2),0);
  bytes memory m = new bytes(63);
  s=m;

 }

function h() public returns (bytes memory){
  s.push();
  return s;
}


 }

 contract test is Test{
  Dirtybytes dirtybytes;
  function testDirtybytes() public{
    dirtybytes= new Dirtybytes();
       emit log_named_bytes(
            "Array element in h() not being zero::",
            dirtybytes.h()
        );
    }


 }