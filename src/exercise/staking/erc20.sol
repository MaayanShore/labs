pragma solidity ^0.8.19;

import "@openzeppelin/ERC20/ERC20.sol";

contract erc20 is ERC20 {
    constructor() ERC20("dai", "dai") {}

    function mint(address add, uint256 amount) public {
        _mint(add, amount);
    }
}