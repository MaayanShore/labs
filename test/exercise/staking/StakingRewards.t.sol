// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "src/exercise/staking/StakingRewards.sol";

import "src/exercise/staking/erc20.sol";
contract StakingRewardsTest is Test {
StakingRewards public stakingRewards;
erc20 stakingToken;


 function setUp() public {
      stakingToken=new erc20();
      stakingRewards= new StakingRewards(address(stakingToken),address( stakingToken));
}

// function test_rate() public
//  {

//     address a1= vm.addr(1);
//     address a2= vm.addr(2);
//     stakingToken.mint(a1, 50);
//     stakingToken.mint(a2, 100);
//     // console.log(stakingRewards.rate);
//     stakingRewards.updateRate(20);
//     // console.log(stakingRewards.rate);

//   }
  
 /*  function test_updateRate() public
 {
   
   stakingRewards.updateRate(1000);
    address Shimon= vm.addr(5);
     vm.startPrank(Shimon);
    stakingRewards.stake(100);
    vm.warp(2);
    console.log(address(Shimon).balance);
    stakingRewards.getReward();
    console.log(address(Shimon).balance);

  console.log(block.timestamp);

 }*/


 }