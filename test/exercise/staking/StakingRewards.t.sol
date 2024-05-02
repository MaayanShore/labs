// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "src/exercise/staking/StakingRewards.sol";

contract StakingRewardsTest is Test {
StakingRewards public stakingRewards;
ERC20 stakingToken;
ERC20 rewardsToken;

 function setUp() public {
      stakingToken=new ERC20('stakingToken');
      rewardsToken=new ERC20('rewardsToken');
      stakingRewards= new StakingRewards(stakingToken, rewardsToken);
}

function test_rate() public
 {
  
    address a1= vm.addr(1);
    address a2= vm.addr(2);
    stakingToken.mint(a1, 50);
    stakingToken.mint(a2, 100);
    console.log(StakingRewards.rate);
    StakingRewards.updateRate(20);
    console.log(StakingRewards.rate);

  }



}