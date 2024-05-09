// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


import "@openzeppelin/ERC20/IERC20.sol";
import "@openzeppelin/ERC721/IERC721.sol";

error  auctionStarted ();
error  auctionNotEnd();
contract EnglishAuction {
 bool public started;
 uint public endAt;
 uint public maxBid;
  uint public tokenId;
 address public owner;
 address public bidAddress;
 address public NFTAddress;
 IERC721 public nft;
 IERC20 public coin;


constructor() {
        owner = msg.sender;

    }
modifier IsOwner() {
    require(msg.sender == owner, "not owner");
        _;
}

modifier Bidder(uint amount){
    require(amount>maxBid , "less than max bid");
    require(started=true , "auction not started");
    _;
}
modifier InAuction(){
    require(block.timestamp< endAt, "action end");
  

    _;
}
function startsAuction(uint _days,uint amount, uint _tokenId) public  {
 if(started ==true)
   revert auctionStarted ();
 tokenId=_tokenId;
 endAt= block.timestamp+(_days*60*24);
 started=true;
 maxBid=amount;
 NFTAddress=msg.sender;
 nft.transferFrom(address(this),NFTAddress, tokenId);
}

function suggest(uint amount) public Bidder(amount) InAuction(){
    if(NFTAddress!=bidAddress)
     coin.transfer(bidAddress, maxBid);
    maxBid = amount;
    bidAddress = msg.sender;
    coin.transferFrom(msg.sender, address(this), amount);
}

function stopAuction() public  {
  if(block.timestamp>=endAt)
    revert auctionNotEnd();
  require(started==true,"auction not started");
  if(NFTAddress!=bidAddress){
   coin.transferFrom(bidAddress, address(this), maxBid);
   nft.transferFrom(bidAddress,address(this), tokenId);}
  started=false;

}



}