// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract hello {
    string public text = "hello world";

    function setText(string memory _text) public {
        text = _text;
    }
} 