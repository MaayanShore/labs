// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract DataLocations{
uint[] public arr;
mapping (uint=>address) public map;
struct MyStruct{
    uint x;
}
mapping (uint=> MyStruct) public myStructs;

function f() public{

    _f(arr, map, myStructs[0]);
 MyStruct storage s=myStructs[0];

MyStruct memory s1=MyStruct(0);
}


function _f(uint[] storage _arrarr,
mapping (uint=>address) storage _map,
MyStruct storage s)   
internal{}

function a(string memory str)public view  returns(string memory st){}

function b(string calldata s)public view  {}
}


