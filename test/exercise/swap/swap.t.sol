// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/exercise/swap/swap.sol";

import "@openzeppelin/ERC20/IERC20.sol";
contract SwapTest is Test {
Swap public swap;
IERC20 tokenA;
IERC20 tokenB;

 function setUp() public {
   
     swap= new Swap(address(tokenA),address(tokenB),5,10);
}
function test_erc20() public
 {

  console.log("gfhfdgdfgdfgdffh",tokenA.balanceOf(address(this)));


 }

}