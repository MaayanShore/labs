// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity 0.8.19;
contract ArrayDeletionBug{

uint [] public arr=[1,2,3,4];

function remove(uint index) public{
  require(index<arr.length, "out range ");
  delete arr[index];
}

function length() public view returns (uint){

    return arr.length;
}

}
contract ArrayDeletionFix{

uint [] public arr=[1,2,3,4];

function remove(uint index) public{
    require(index<arr.length, "out range ");
  arr[index]=arr[arr.length-1];
  arr.pop();
}

function length() public view returns (uint){

    return arr.length;
}
}
contract contractTest is Test{

ArrayDeletionFix arrayDeletionFix=new ArrayDeletionFix();
ArrayDeletionBug arrayDeletionBug=new ArrayDeletionBug();

function test_ArrayDeletionBug() public {
    
arrayDeletionBug.remove(1);
console.log(arrayDeletionBug.length());

}

function test_ArrayDeletionFix() public {
arrayDeletionFix.remove(1);
console.log(arrayDeletionFix.length());

}


}

