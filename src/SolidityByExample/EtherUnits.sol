// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract EtherUnits{

uint public _wei =1 wei;
bool public Cwei= (_wei== 1);

uint public _gwei =1 gwei;
bool public Cgwai =(_gwei == 1e9);

uint public _ether =1 ether;
bool public Cether =(_ether ==1e18);
}