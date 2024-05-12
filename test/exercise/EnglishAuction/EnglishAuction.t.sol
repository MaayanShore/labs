// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/exercise/englishAuction/englishAuction.sol";
import "src/exercise/englishAuction/NFT.sol";
import "src/exercise/staking/erc20.sol";
import "src/exercise/staking/erc20.sol";
contract EnglishAuctionTest is Test {
EnglishAuction public englishAuction;
 IERC721 nft1 ;
Nft nft;
erc20 token;
 function setUp() public {
    token= new erc20();
      englishAuction= new EnglishAuction(address(token));
       nft=new Nft();
      
}

function test_startsAuction() public{
uint tokenId=1;
address a1= vm.addr(1); 
nft.mint(a1,tokenId);
vm.startPrank(a1); 
 nft.approve(address(englishAuction), tokenId);
  assertEq(nft.ownerOf(tokenId), a1, "NFT was not minted successfully");
 englishAuction.startsAuction(7,10,1,address(nft));
 assertEq(nft.ownerOf(tokenId), address(englishAuction), "NFT was not transfred successfully");

}
function test_ownerNft() public{
uint tokenId=1;
address a1= vm.addr(1); 
nft.mint(a1,tokenId);
vm.prank(a1);
 nft.approve(address(englishAuction), tokenId);
  vm.expectRevert();
 englishAuction.startsAuction(7,10,1,address(nft));
 
}
function test_suggest() public  {
 address a1= vm.addr(1);
 nft.mint(a1,1);
vm.prank(a1);
token.mint(a1,100);
vm.startPrank(a1); 
  console.log("gvfgvgvvghvhg");
uint balanceBefore=token.balanceOf(a1);
 nft.approve(address(englishAuction), 1);
token.approve(address(englishAuction), 100);
englishAuction.startsAuction(7,10,1,address(nft));
englishAuction.suggest(15);
assertEq(balanceBefore-15, token.balanceOf(a1),"money not taken");
}

function test_suggestfailed() public  {
 address a1= vm.addr(1);
 nft.mint(a1,1);
vm.prank(a1);
token.mint(a1,100);
vm.startPrank(a1); 

 nft.approve(address(englishAuction), 1);
 token.approve(address(englishAuction), 100);
  englishAuction.startsAuction(7,10,1,address(nft));
  vm.expectRevert();
englishAuction.suggest(7);

}
function test_stopAuctionfailed() public  {
 address a1= vm.addr(1);
 nft.mint(a1,1);
vm.prank(a1);
token.mint(a1,100);
vm.startPrank(a1); 

 nft.approve(address(englishAuction), 1);
 token.approve(address(englishAuction), 100);
 englishAuction.startsAuction(7,10,1,address(nft));
vm.expectRevert(); 
englishAuction.stopAuction();
}
function test_stopAuction() public  {
 address a1= vm.addr(1);
 nft.mint(a1,1);
vm.prank(a1);
token.mint(a1,100);
vm.startPrank(a1); 

 nft.approve(address(englishAuction), 1);

 englishAuction.startsAuction(7,10,1,address(nft));
vm.stopPrank(); 
 address a2= vm.addr(2);
vm.startPrank(a2);
 
 token.mint(a2,100);
 token.approve(address(englishAuction), 100);
englishAuction.suggest(15);

vm.stopPrank();
uint balanceBefore=token.balanceOf(a1);
vm.warp(block.timestamp + 7 days);
englishAuction.stopAuction();
 console.log(token.balanceOf(a1));
  console.log(balanceBefore);
assertEq(balanceBefore+15, token.balanceOf(a1),"money not given");
 assertEq(nft.ownerOf(1), address(a2), "NFT was not transfred successfully");
}

function test_stopAuctionOwmer() public  {
 address a1= vm.addr(1);
 nft.mint(a1,1);
vm.prank(a1);
token.mint(a1,100);
vm.startPrank(a1); 

 nft.approve(address(englishAuction), 1);

 englishAuction.startsAuction(7,10,1,address(nft));
vm.stopPrank(); 

uint balanceBefore=token.balanceOf(a1);
vm.warp(block.timestamp + 7 days);
englishAuction.stopAuction();
 console.log(token.balanceOf(a1));
  console.log(balanceBefore);
assertEq(balanceBefore, token.balanceOf(a1),"money not given");
 assertEq(nft.ownerOf(1), address(a1), "NFT was not transfred successfully");
}
function test_nostartAuction() public  {
vm.expectRevert(); 
englishAuction.stopAuction();

}
}