// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Swap{

 IERC20 public  tokenA;
 IERC20 public  tokenB;
 address public owner;
 uint256 public balanceA;
 uint256 public balanceB;
 uint256 public initialA;
 uint256 public initialB;
modifier onlyOwner() {
  require(msg.sender == owner, "not authorized");
        _;
}

constructor(address a, address b,uint _balanceA,uint _balanceB) {
        owner = msg.sender;
        tokenA = IERC20(a);
        tokenB = IERC20(b);
        
        tokenA.transferFrom(msg.sender, address(this), _balanceA);
        tokenB.transferFrom(msg.sender, address(this), _balanceB);
    }

 function  price() public view returns (uint256)
 {
    return balanceA*balanceB;
 }  
function  tradeAToB(uint amountA) public {
   require(amountA > 0, "amount = 0");
   require(balanceA > amountA, "balance not enough "); 
   tokenA.transferFrom(msg.sender, address(this), amountA);
   balanceA=balanceA+amountA;
   uint b=price()/balanceA;
   tokenB.transfer(msg.sender, balanceB-b);
   balanceB=b;
}

function  tradeBToA(uint amountB) public {
   require(amountB > 0, "amount = 0");
   require(balanceB > amountB, "balance not enough "); 
   tokenB.transferFrom(msg.sender, address(this), amountB);
   balanceB=balanceB+amountB;
   uint a=price()/balanceB;
   tokenA.transfer(msg.sender, balanceA-a);
   balanceA=a;
}

function addLiquidity(uint amountA,uint amountB) public{

require(amountB > 0 &&  amountA > 0, "amount = 0");

 tokenA.transferFrom(msg.sender, address(this), amountA);
   balanceA=balanceA+amountA;
    tokenB.transferFrom(msg.sender, address(this), amountB);
   balanceB=balanceB+amountB;
}

  function removeLiquidity(uint amountA,uint amountB) public{

require(amountB <  balanceB &&  amountA < balanceA, "amount too big ");

 tokenA.transfer(msg.sender,  amountA);
   balanceA=balanceA-amountA;
    tokenB.transfer(msg.sender,  amountB);
   balanceB=balanceB-amountB;

  }

}