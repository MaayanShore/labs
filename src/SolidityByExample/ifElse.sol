// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract ifElse{
function foo(uint x) public returns(uint256){
 if(x<10)
 return 1;
 else if(x<20)
 return 2;
 else
 return 3;

}
function ternary(uint x) public pure returns(uint256){
  return x<10?1:2;


}
}