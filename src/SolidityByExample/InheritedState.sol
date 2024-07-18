// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract A{
 string public name="A";
 function getName() view public returns(string memory){
  return name;
}

}

// contract B is A{
//  string public name="B";
// }

contract C is A{

  constructor(){ 
   name="C";} 
}