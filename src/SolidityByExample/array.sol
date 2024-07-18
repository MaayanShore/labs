// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Array {
uint256[] public arr;
uint[] public arr2=[1,2,3];
uint[10] public arr3;

function get(uint i) public view returns (uint){
 return arr[i];
}
function getArr() public view returns (uint[] memory){
  return arr;
}

function push( uint x) public  {
 arr.push(x);
}
function pop() public{
    arr.pop();
}
function length() view public{
  arr.length;
}
function remove(uint i) public {
  delete arr[i];
}
function _memory() public pure{
  uint[] memory a=new uint[](5);
}

function ArrayRemoveByShifting(uint index) public{
 require(index<arr.length,"out of bound");
 for(uint i=index; i<arr.length-1; i++){
    arr[i]=arr[i+1]; }
    arr.pop();
}
function ArrayRemoveEnd(uint index) public{
 require(index<arr.length,"out of bound");

    arr[index]=arr[arr.length-1];
    arr.pop();

}
}