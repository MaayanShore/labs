// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.19;
// contract Error{

// function test_require(uint x) public 
// {
//   require(x<10,"too big");
// }

// function test_revert(uint x) public 
// {
//    if(x<10)
//   revert("too big");
// }

// function test_assert(uint x) public 
// {
//    assert(x==10);
// }

//  error InsufficientBalance(uint balnce, uint withdrwaAmount);

//  function test_error(uint amount ) public{
   
//    uint bal=address(this).balance();
//    if(bal<amount)
//     emit InsufficientBalance(bal, amount);
//  }

// }