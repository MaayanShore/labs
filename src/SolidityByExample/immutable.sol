// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Immutable {

address public immutable MY_ADDRESS;
uint public immutable MY_UINT;

constructor(uint n){

    MY_ADDRESS=msg.sender;
    MY_UINT=n;
}

}