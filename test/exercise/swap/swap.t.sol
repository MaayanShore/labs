// // SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/exercise/swap/swap.sol";

import "@openzeppelin/ERC20/IERC20.sol";
import "src/exercise/staking/erc20.sol";

contract SwapTest is Test {
Swap public swap;
erc20 public tokenA;
erc20 public tokenB;

 function setUp() public {
    tokenA = new erc20();
    tokenB = new erc20();
    console.log(address(tokenA));
    console.log(address(tokenB));
     swap= new Swap(address(tokenA),address(tokenB),5,10);
}
function test_erc20() public view
 {

  console.log("gfhfdgdfgdfgdffh",tokenA.balanceOf(address(this)));

 }

}
