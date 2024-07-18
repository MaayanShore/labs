// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Event {
event Log(address indexed sender, string message);
event Log2();

function test() public{
    emit Log(msg.sender,"hello");
    emit Log(msg.sender,"evm");
    emit Log2();
}

}