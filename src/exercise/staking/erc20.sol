//SPDX-License-Identifier: MIT
//Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/ERC20.sol";

contract erc20 is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
    }
    function mint(address add, uint amount) public {
        _mint(add , amount);
    }
}