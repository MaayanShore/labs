// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Primitive {
 
 bool public boo=true;

 uint8 public u8= 1;
 uint256 public u256= 456;
 uint256 public u=  123;

 int8 public i8=-1;
 int256 public i256 =456;
 int256 public i= -123;

 int256 public max= type(int256).max;
 int256 public min =type(int256).min;

address ad=0x425a024816fBd7A08c8258357cCfCEB802E2d0cd;

bytes1 a=0xb5;
bytes1 b=0x59;

uint256 public _uint;
int256 public _int;
bool public boo1;
address _address;


}