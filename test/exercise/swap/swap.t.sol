// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "src/exercise/swap/swap.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract SwapTest is Test {
Swap public swap;
ERC20 tokenA;
ERC20 tokenB;

 function setUp() public {
   
    //  swap= new Swap(address(tokenA),address(tokenB),5,10);
}
function test_erc20() public
 {

  console.log("gfhfdgdfgdfgdffh",tokenA.balanceOf(address(this)));


 }

}