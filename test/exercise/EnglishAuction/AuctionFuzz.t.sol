// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "src/exercise/englishAuction/englishAuction.sol";
import "src/exercise/englishAuction/NFT.sol";
import "src/exercise/staking/erc20.sol";
import "src/exercise/staking/erc20.sol";

contract EnglishAuctionFuzzTest is Test {
    EnglishAuction public englishAuction;
    IERC721 nft1;
    Nft nft;
    erc20 token;

    function setUp() public {
        token = new erc20();
        englishAuction = new EnglishAuction(address(token));
        nft = new Nft();
    }

    function testfuzz_startsAuction(uint256 tokenId, uint96 _days, uint256 amount) public {
        console.log("tokenId", tokenId);
        console.log(_days);
        console.log(amount);
        //uint _days=7;
        // uint amount=10;
        address a1 = vm.addr(100);
        nft.mint(a1, tokenId);
        vm.startPrank(a1);
        nft.approve(address(englishAuction), tokenId);
        assertEq(nft.ownerOf(tokenId), a1, "NFT was not minted successfully");
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
        assertEq(nft.ownerOf(tokenId), address(englishAuction), "NFT was not transfred successfully");
    }

    function testFuzz_ownerNft(uint256 tokenId, uint256 _days, uint256 amount) public {
        address a1 = vm.addr(1);
        nft.mint(a1, tokenId);
        vm.prank(a1);
        nft.approve(address(englishAuction), tokenId);
        vm.expectRevert();
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
    }

    function testFuzz_suggest(uint256 tokenId) public {
        uint256 _days = 7;
        uint256 amount = 10;
        uint256 amounts = 15;
        console.log("tokenId", tokenId);
        console.log(_days);
        console.log(amount);
        console.log(amounts);
        vm.assume(amounts > amount);
        address a1 = vm.addr(1);
        address a2 = vm.addr(2);
        nft.mint(a1, tokenId);
        token.mint(a2, amounts);
        token.mint(a1, amount);
        vm.startPrank(a1);
        nft.approve(address(englishAuction), tokenId);
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
        vm.stopPrank();
        vm.startPrank(a2);
        uint256 balanceBefore = token.balanceOf(a2);
        token.approve(address(englishAuction), amounts);
        englishAuction.suggest(amounts);
        assertEq(balanceBefore - amounts, token.balanceOf(a2), "money not taken");
    }

    function testFuzz_suggestfailed(uint256 tokenId, uint96 _days, uint256 amount, uint256 amounts) public {
        vm.assume(amounts < amount);
        address a1 = vm.addr(1);
        nft.mint(a1, tokenId);
        vm.prank(a1);
        token.mint(a1, amounts);
        vm.startPrank(a1);
        nft.approve(address(englishAuction), tokenId);
        token.approve(address(englishAuction), amounts);
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
        vm.expectRevert();
        englishAuction.suggest(amounts);
    }

    function testFuzz_stopAuctionfailed(uint256 tokenId, uint96 _days, uint256 amount) public {
        address a1 = vm.addr(1);
        nft.mint(a1, tokenId);
        vm.prank(a1);
        token.mint(a1, amount);
        vm.startPrank(a1);
        nft.approve(address(englishAuction), tokenId);
        token.approve(address(englishAuction), amount);
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
        vm.expectRevert();
        englishAuction.stopAuction();
    }

    function testFuzz_stopAuction(uint256 tokenId, uint256 _days, uint256 amount, uint96 amounts) public {
        // uint _days=7;
        vm.assume(_days > 0 && _days < 1955555599999999999999999999994);
        vm.assume(amount > 0.1 ether);
        vm.assume(tokenId > 0);
        vm.assume(amounts > 0.1 ether);
        vm.assume(amounts > amount);
        console.log("tokenId", tokenId);
        console.log(_days);
        console.log(amount);
        console.log(amounts);

        address a1 = vm.addr(100);
        nft.mint(a1, tokenId);
        vm.prank(a1);
        token.mint(a1, amount);
        vm.startPrank(a1);
        nft.approve(address(englishAuction), tokenId);
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
        vm.stopPrank();
        address a2 = vm.addr(222);
        vm.startPrank(a2);
        token.mint(a2, amounts);
        token.approve(address(englishAuction), amounts);
        englishAuction.suggest(amounts);
        vm.stopPrank();
        uint256 balanceBefore = token.balanceOf(a1);
        vm.warp(block.timestamp + _days * 1 days);
        englishAuction.stopAuction();
        console.log(token.balanceOf(a1));
        console.log(balanceBefore);
        assertEq(balanceBefore + amounts, token.balanceOf(a1), "money not given");
        assertEq(nft.ownerOf(tokenId), address(a2), "NFT was not transfred successfully");
    }

    function testFuzz_stopAuctionOwmer(uint256 tokenId, uint256 _days, uint256 amount) public {
        vm.assume(_days > 0 && _days < 1955555599999999999999999999994);
        vm.assume(amount > 0.1 ether);
        vm.assume(tokenId > 0);

        address a1 = vm.addr(1);
        nft.mint(a1, tokenId);
        vm.prank(a1);
        token.mint(a1, amount);
        vm.startPrank(a1);
        nft.approve(address(englishAuction), tokenId);
        englishAuction.startsAuction(_days, amount, tokenId, address(nft));
        vm.stopPrank();
        uint256 balanceBefore = token.balanceOf(a1);
        vm.warp(block.timestamp + _days * 1 days);
        englishAuction.stopAuction();
        console.log(token.balanceOf(a1));
        console.log(balanceBefore);
        assertEq(balanceBefore, token.balanceOf(a1), "money not given");
        assertEq(nft.ownerOf(tokenId), address(a1), "NFT was not transfred successfully");
    }

    function testFuzz_nostartAuction() public {
        vm.expectRevert();
        englishAuction.stopAuction();
    }
}
