// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Function{

function a() public pure returns(uint ,uint , uint ){

return(1,2,3);
}
function b() public pure returns(uint x,uint y, uint z){
return(1,2,3);
}
function c()public pure returns(uint t,uint u, uint v){
t=1;
u=2;
v=3;
}

function d(uint[] memory arr)public pure{}

uint[] arr2;
function e() public view returns(uint[] memory){
    return arr2;
}

function f() public pure returns(uint,uint,uint){
  (uint l,uint n,uint p)= c();

  //(uint s,uint g)= (1,2,3);
  return (l,n,p);
}

function g(
    uint j,
    bool w,
    address m
) public pure {}

function h() public view{
g(1,false,address(this));

}

function i() public view{
    g({ w:true,
        m:address(this),
        j:6});
}
}