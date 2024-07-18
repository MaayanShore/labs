// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@openzeppelin/ERC20/IERC20.sol";
import "@openzeppelin/ERC721/IERC721.sol";
import "forge-std/console.sol";
import "src/exercise/Lending/ERC20Burnable.sol";

contract Lending {  
    
    struct borrower {
        uint256 amountborrow;
        uint256 amountcollateral;
    }
    uint public poolValue;
    uint public collateralValue;
    uint public borrowlValue;
    uint public ratio =660000000000000000;
    uint ETHvalue = 1000;
    uint wad=10**18;
    uint public borrowingFee= 10000000000000000;
    address public owner;
    IERC20 public dai;
    ERC20Burnable public bond;
    IERC20 public eth;
    mapping(address => uint256) public depositors;
    mapping(address => borrower) public borrowers;
    constructor(address _dai, address _bond,address _eth) {
        owner = msg.sender;
        dai = IERC20(_dai);
        bond = ERC20Burnable(_bond);
        eth = IERC20(_eth);
    }
        modifier IsOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }
        modifier IsPosetive(uint amount) {
        require(amount>0,"amount not bigger then 0");
        _;
    }

function deposit(uint amount) IsPosetive(amount) public {
  dai.transferFrom(msg.sender,address(this), amount);
  depositors[msg.sender]+=amount;
  poolValue+= amount;
  bond.mint(msg.sender, amount);
}
 function unbond (uint amount) IsPosetive(amount)public {
  require(amount<=depositors[msg.sender],"amount not bigger then 0");
  bond.burn(amount);
  dai.transfer(msg.sender, amount);
  depositors[msg.sender]-=amount;
  poolValue-= amount;
 }

function addCollateral (uint amount) public  IsPosetive(amount){
  eth.transferFrom(msg.sender,address(this), amount);
  collateralValue+=amount;
  borrowers[msg.sender].amountcollateral+=amount;
}
 
 function removeCollateral (uint amount) public  IsPosetive(amount){
  borrowers[msg.sender].amountcollateral-=amount; 
  uint needCollateral=DaiforETH(msg.sender);
  require( needCollateral>borrowers[msg.sender].amountborrow, "not enogth collateral");
  eth.transfer(msg.sender, amount);
  collateralValue-=amount;
} 

function _borrow(uint amount) public  IsPosetive(amount){
uint daiPrice=DaiforETH(msg.sender);
require(daiPrice>amount+borrowers[msg.sender].amountborrow, "not enogth collateral");
require(poolValue>amount, "not enogth money in the pool");
require(borrowers[msg.sender].amountborrow==0, "you have a borrow");
dai.transfer(msg.sender, amount);
borrowers[msg.sender].amountborrow+=amount;
borrowlValue+=amount;
poolValue-= amount;
}
 
function repay(uint amount) public IsPosetive(amount){
uint amountborrow= borrowers[msg.sender].amountborrow;
require(amountborrow*borrowingFee+amountborrow>amount, "amount bigger then what borrowerd");
dai.transferFrom(msg.sender,address(this), amount);
borrowers[msg.sender].amountborrow-=amountborrow;
borrowlValue-=amountborrow;
poolValue+= amountborrow;
}

function DaiforETH(address borrow) public view returns (uint) {
       
       return ETHvalue * ratio * borrowers[borrow].amountcollateral;
 }
}