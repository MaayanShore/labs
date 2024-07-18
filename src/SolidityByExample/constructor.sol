// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract X{
 string public text;
 constructor(string memory _text){
    text=_text;
 }

}

contract Y{
 string public str;
 constructor(string memory _str){
    str=_str;
 }

}

contract B is X( "x" ), Y ("y"){
}

contract C is X, Y {
    constructor (string memory _text, string memory _str) X(_text) Y(_str){}
}

contract D is X, Y {
    constructor (string memory _text, string memory _str) Y(_text) X(_str){}
}