// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Mapping {

mapping(address => uint) public map;

function get(address adr)public view returns(uint){

    return map[adr];
}

function set(address adr, uint i) public {

    map[adr]=i;
}
function remove(address adr)public {

    delete map[adr];
}
}

contract NestedMapping {

mapping(address =>mapping (uint => bool)) public  map;

function get(address adr, uint i)public view returns(bool){

    return map[adr][i];
}

function set(address adr, uint i, bool b) public {

    map[adr][i]=b;
}
function remove(address adr, uint i)public {

    delete map[adr][i];
}
}