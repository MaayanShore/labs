// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
contract erc20 is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
    }
    function mint(address add, uint amount) public {
        _mint(add , amount);
    }
}