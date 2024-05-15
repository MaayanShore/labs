//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/exercise/swap/cp.sol";

import "@openzeppelin/ERC20/IERC20.sol";

contract CpTest is Test {
    CP public cp;
    IERC20 tokenA;
    IERC20 tokenB;

    function setUp() public {
        cp = new CP(address(tokenA), address(tokenB));
    }

    // function test_swap() public
    //  {
    //     address checkAddress1= vm.addr(1);
    //     tokenA.mint(checkAddress1, 200);
    //     tokenB.mint(checkAddress1, 200);
    //     vm.prank(checkAddress1);
    //     cp.addLiquidity(5, 10);
    //     address checkAddress2= vm.addr(2);
    //     tokenA.mint(checkAddress2, 200);
    //     tokenB.mint(checkAddress2, 200);
    //     vm.prank(checkAddress2);
    //     cp.addLiquidity(15, 30);
    //     address checkAddress3= vm.addr(3);
    //     tokenA.mint(checkAddress3, 200);
    //     tokenB.mint(checkAddress3, 200);
    //     vm.startPrank(checkAddress3);
    //     cp.addLiquidity(1, 2);
    //     console.log(cp.swap(address(tokenA), 5));
    //  }
}
