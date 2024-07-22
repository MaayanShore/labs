// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Error{

function test_require(uint x) pure public 
{
  require(x<10,"too big");
}

function test_revert(uint x) public pure
{
   if(x<10)
  revert("too big");
}

function test_assert(uint x) public pure
{
   assert(x==10);
}

 error InsufficientBalance(uint balance, uint withdrawAmount);

 function test_error(uint amount ) view public{
   
   uint bal=address(this).balance;
   if(bal<amount)
      revert InsufficientBalance({
                balance: bal,
                withdrawAmount: amount
            });
 }

}