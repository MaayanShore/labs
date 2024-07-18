// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
contract Enum{
 enum Status{
    pending,
    Shipped,
    cancelacion
 }
 Status public status;

 function get() public view  returns(Status)
 {
   return status;
 }
 
  function set(Status _status) public 
 {
   status=_status;
 }

 function update() public {
    status=Status.pending;
 }

  function remove() public {
   delete status;
 }

}