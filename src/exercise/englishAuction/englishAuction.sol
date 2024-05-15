// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@openzeppelin/ERC20/IERC20.sol";
import "@openzeppelin/ERC721/IERC721.sol";
import "forge-std/console.sol";

error auctionStarted();
error auctionNotEnd();

contract EnglishAuction {
    bool public started;
    uint256 public endAt;
    uint256 public maxBid;
    uint256 public tokenId;
    address public owner;
    address public bidAddress;
    address public NFTAddress;
    IERC721 public nft;
    IERC20 public coin;

    constructor(address token) {
        owner = msg.sender;
        started == false;
        coin = IERC20(token);
    }

    modifier IsOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier Bidder(uint256 amount) {
        require(amount > maxBid, "less than max bid");
        require(started == true, "auction not started");
        _;
    }

    modifier InAuction() {
        require(block.timestamp < endAt, "action end");

        _;
    }

    function startsAuction(uint256 _days, uint256 amount, uint256 _tokenId, address _nft) public {
        if (started == true) {
            revert auctionStarted();
        }
        nft = IERC721(_nft);
        address checkOwner = nft.ownerOf(_tokenId);

        require(checkOwner == msg.sender, "not owner of the nft!");
        tokenId = _tokenId;
        endAt = block.timestamp + (_days * 60 * 24);
        started = true;
        maxBid = amount;
        NFTAddress = msg.sender;
        bidAddress = msg.sender;
        nft.transferFrom(NFTAddress, address(this), tokenId);
    }

    function suggest(uint256 amount) public Bidder(amount) InAuction {
        if (NFTAddress != bidAddress) {
            coin.transfer(bidAddress, maxBid);
        }
        maxBid = amount;
        bidAddress = msg.sender;
        coin.transferFrom(msg.sender, address(this), amount);
    }

    function stopAuction() public {
        if (block.timestamp <= endAt) {
            revert auctionNotEnd();
        }
        require(started == true, "auction not started");
        if (NFTAddress != bidAddress) {
            coin.transfer(NFTAddress, maxBid);
            nft.transferFrom(address(this), bidAddress, tokenId);
        } else {
            nft.transferFrom(address(this), NFTAddress, tokenId);
        }
        started = false;
    }

    receive() external payable {}
}
