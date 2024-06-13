// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IERC20 {  

    function transfer(address reciver , uint amount) external  returns (bool);

    function transferFrom(address sender, address reciver , uint amount) external  returns (bool);

    function approve(address spender , uint amount) external  returns (bool);

    function balanceOf(address owner ) external  returns (uint);

    //function allowance(address owner, address spender , uint amount) external  returns (bool);

    event Transfer(address indexed sender, address indexed reciver , uint amount);

    event Approval(address indexed owner, address indexed spender, uint value);
} 

contract ERC20 is IERC20{
 uint totalSupply;
 mapping(address => uint) public balances; 
 mapping(address => mapping (address => uint) ) public allowance; 

 function transfer(address reciver , uint amount) external  returns (bool)
 {
   balances[msg.sender]-=amount;
   balances[reciver]+=amount;
   emit Transfer(msg.sender,  reciver ,  amount);
   return true;
}

 function transferFrom(address sender, address reciver , uint amount) external  returns (bool){
    allowance[sender][msg.sender]-=amount;
   balances[sender]-=amount;
   balances[reciver]+=amount;
   emit Transfer(sender,  reciver ,  amount);
   return true;
}

 function balanceOf(address recive ) external view returns (uint)
{
    return  balances[recive];
}

function approve(address spender , uint amount) external  returns (bool){
   allowance[msg.sender][spender]+=amount;
   emit Approval( msg.sender, spender,amount);
   return true;
}
}