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
  mapping(address => uint256) public liquidity_providers;  
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

        balanceA=_balanceA;
        balanceB =_balanceB;
    }

 function  price() public view returns (uint256)
 {
    return balanceA*balanceB;
 }  


 function  give(uint balance1, uint balance2) public view returns (uint256)
 {  
    uint amount=price()/balance1;
    uint gives=balance2-amount;
    return gives;
 }
function  tradeAToB(uint amountA) public {
   require(amountA > 0, "amount = 0");
        
   tokenA.transferFrom(msg.sender, address(this), amountA);
   balanceA=balanceA+amountA;
   uint gives=give(balanceA,balanceB);
   if (balanceB < gives) 
    revert();
   else {
    tokenB.transfer(msg.sender,gives);
    balanceB=gives;
    }
}

function  tradeBToA(uint amountB) public {
   require(amountB > 0, "amount = 0");
   
   tokenB.transferFrom(msg.sender, address(this), amountB);
   balanceB=balanceB+amountB;
   uint gives=give(balanceB,balanceA);
   if (balanceA < gives )
    revert();
   else {
   tokenA.transfer(msg.sender, gives);
   balanceA=gives;
   }

}

function addLiquidityA(uint amountA) public{

  require(amountA > 0, "amount = 0");
   uint prop= balanceB/balanceA;
   uint put= prop*amountA;
   require(msg.sender.balance > put, "amount = 0");
   
   tokenA.transferFrom(msg.sender, address(this), amountA);
   balanceA=balanceA+amountA;
   tokenB.transferFrom(msg.sender, address(this), put);
   balanceB=balanceB+put;
}
function addLiquidityB(uint amountB) public{

  require(amountB > 0, "amount = 0");
   uint prop= balanceA/balanceB;
   uint put= prop*amountB;
   require(msg.sender.balance > put, "amount = 0");
   
   tokenB.transferFrom(msg.sender, address(this), amountB);
   balanceB=balanceB+amountB;
   tokenA.transferFrom(msg.sender, address(this), put);
   balanceA=balanceA+put;
}

  function removeLiquidity(uint amountA,uint amountB) public{

   require(amountB <  balanceB &&  amountA < balanceA, "amount too big ");

   tokenA.transfer(msg.sender,  amountA);
   balanceA=balanceA-amountA;
   tokenB.transfer(msg.sender,  amountB);
   balanceB=balanceB-amountB;

  }

}