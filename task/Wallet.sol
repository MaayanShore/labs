// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Wallet {
    address private owner;
    mapping(address => uint256) allowedWithdrawers;
    uint256 numAllowedWithdrawers=0;

   constructor() {
        owner = msg.sender;
    }

    modifier IsOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }
   modifier IsOwnerOrAllowed() {
        require(msg.sender == owner || allowedWithdrawers[msg.sender]>0 , "Not owner or allowed");
        _;
    }

    function addAllowedWithdrawers(address _address) public IsOwner {
        require(numAllowedWithdrawers < 3, "Maximum allowed withdrawers reached");
        allowedWithdrawers[_address] = numAllowedWithdrawers;
        numAllowedWithdrawers++;
    }
   
   function changeAllowedWithdrawers(address _address, address newAddress)public IsOwner{
        uint256 oldAmount = allowedWithdrawers[_address];
        delete allowedWithdrawers[_address];
        allowedWithdrawers[newAddress] = oldAmount;
   }
   receive() external  payable 
   {   }
       
    function withdraw(uint256 amount) public IsOwnerOrAllowed {
        require(amount <= address(this).balance, "Insufficient balance");
        payable(owner).transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
