// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12 <0.9.0;

contract Wallet {
    address private owner;
    address[3] private allowedWithdrawers;
    uint256 numAllowedWithdrawers=0;

   constructor() {
        owner = msg.sender;
    }

    modifier IsOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }
   modifier IsOwnerOrAllowed() {
        require(msg.sender == owner || msg.sender==allowedWithdrawers[0] ||  msg.sender==allowedWithdrawers[1] || msg.sender==allowedWithdrawers[2] , "Not owner or allowed");
        _;
    }

    function addAllowedWithdrawers(address _address) public IsOwner {
        require(numAllowedWithdrawers < 3, "Maximum allowed withdrawers reached");
        allowedWithdrawers[numAllowedWithdrawers] = _address;
        numAllowedWithdrawers++;
    }
   
   function changeAllowedWithdrawers(address _address, address newAddress)public IsOwner{
       if(_address==allowedWithdrawers[0])
         allowedWithdrawers[0] = newAddress;
        if(_address==allowedWithdrawers[1])
         allowedWithdrawers[1] = newAddress;
        if(_address==allowedWithdrawers[2])
         allowedWithdrawers[2] = newAddress;
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
