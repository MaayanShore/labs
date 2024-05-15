// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@openzeppelin/ERC20/IERC20.sol";

contract Swap {
    IERC20 public tokenA;
    IERC20 public tokenB;
    address public owner;
    uint256 public balanceA;
    uint256 public balanceB;
    uint256 public initialA;
    uint256 public initialB;
    mapping(address => uint256) public liquidity_providers;

    modifier onlyOwner() {
        require(msg.sender == owner, "not authorized");
        _;
    }

    constructor(address a, address b, uint256 _balanceA, uint256 _balanceB) {
        owner = msg.sender;
        tokenA = IERC20(a);
        tokenB = IERC20(b);

        tokenA.transferFrom(msg.sender, address(this), _balanceA);
        tokenB.transferFrom(msg.sender, address(this), _balanceB);

        balanceA = _balanceA;
        balanceB = _balanceB;
    }

    function price() public view returns (uint256) {
        return balanceA * balanceB;
    }

    function give(uint256 balance1, uint256 balance2) public view returns (uint256) {
        uint256 amount = price() / balance1;
        uint256 gives = balance2 - amount;
        return gives;
    }

    function tradeAToB(uint256 amountA) public {
        require(amountA > 0, "amount = 0");

        tokenA.transferFrom(msg.sender, address(this), amountA);
        balanceA = balanceA + amountA;
        uint256 gives = give(balanceA, balanceB);
        require(balanceA > gives, "not enough balance");
        tokenB.transfer(msg.sender, gives);
        balanceB = gives;
    }

    function tradeBToA(uint256 amountB) public {
        require(amountB > 0, "amount = 0");

        tokenB.transferFrom(msg.sender, address(this), amountB);
        balanceB = balanceB + amountB;
        uint256 gives = give(balanceB, balanceA);
        require(balanceA > gives, "not enough balance");
        tokenA.transfer(msg.sender, gives);
        balanceA = gives;
    }

    function addLiquidityA(uint256 amountA) public {
        require(amountA > 0, "amount = 0");
        uint256 prop = balanceB / balanceA;
        uint256 put = prop * amountA;
        require(msg.sender.balance > put, "amount = 0");

        tokenA.transferFrom(msg.sender, address(this), amountA);
        balanceA += amountA;
        tokenB.transferFrom(msg.sender, address(this), put);
        balanceB += put;
        liquidity_providers[msg.sender] += amountA;
    }

    function addLiquidityB(uint256 amountB) public {
        require(amountB > 0, "amount = 0");
        uint256 prop = balanceA / balanceB;
        uint256 put = prop * amountB;
        require(msg.sender.balance > put, "amount = 0");

        tokenB.transferFrom(msg.sender, address(this), amountB);
        balanceB = balanceB + amountB;
        tokenA.transferFrom(msg.sender, address(this), put);
        balanceA = balanceA + put;
        liquidity_providers[msg.sender] += put;
    }

    function removeLiquidity(uint256 amount) public {
        uint256 amountA = liquidity_providers[msg.sender];
        require(amount < balanceA, "amount too big ");

        uint256 prec = amountA / balanceA;
        uint256 amountB = price() / 100 * prec;
        tokenA.transfer(msg.sender, amountA);
        balanceA = balanceA - amountA;
        tokenB.transfer(msg.sender, amountB);
        balanceB = balanceB - amountB;
    }
}
