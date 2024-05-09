// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


import "@openzeppelin/ERC20/IERC20.sol";

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
    require(balanceA > gives,"not enough balance" );
    tokenB.transfer(msg.sender,gives);
    balanceB=gives;
    }


function  tradeBToA(uint amountB) public {
   require(amountB > 0, "amount = 0");
   
   tokenB.transferFrom(msg.sender, address(this), amountB);
   balanceB=balanceB+amountB;
   uint gives=give(balanceB,balanceA);
   require(balanceA > gives,"not enough balance" );
   tokenA.transfer(msg.sender, gives);
   balanceA=gives;
   }

function addLiquidityA(uint amountA) public{

  require(amountA > 0, "amount = 0");
   uint prop= balanceB/balanceA;
   uint put= prop*amountA;
   require(msg.sender.balance > put, "amount = 0");
   
   tokenA.transferFrom(msg.sender, address(this), amountA);
   balanceA+=amountA;
   tokenB.transferFrom(msg.sender, address(this), put);
   balanceB+=put;
   liquidity_providers[msg.sender]+=amountA;
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
   liquidity_providers[msg.sender]+=put;
}

  function removeLiquidity(uint amount) public{
   uint amountA=liquidity_providers[msg.sender];
   require( amount < balanceA, "amount too big ");

   uint prec=amountA/ balanceA;
   uint amountB=price()/100*prec;
   tokenA.transfer(msg.sender,  amountA);
   balanceA=balanceA-amountA;
   tokenB.transfer(msg.sender,  amountB);
   balanceB=balanceB-amountB;

  }

}