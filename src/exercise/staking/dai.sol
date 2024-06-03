//SPDX-License-Identifier: MIT
//Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.19;

import "@openzeppelin/ERC20/ERC20.sol";

contract dai is ERC20 {
    constructor() ERC20("dai", "dai") {}

    function mint(address add, uint256 amount) public {
        _mint(add, amount);
    }
}
