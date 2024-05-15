//SPDX-License-Identifier: MIT
//Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/ERC721/ERC721.sol";

contract Nft is ERC721 {
    constructor() ERC721("MyNFT", "MNFT") {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
    // function transferFrom(address from, address to, uint256 tokenId) override external {}
    // function approve(address to, uint256 tokenId) override external {}
    // function transfer(address to, uint256 tokenId) external {}
    // function safeTransferFrom(address from, address to, uint256 tokenId) external override {}
    // function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) external override {}
    // function balanceOf(address owner) external view override returns (uint256) {}
    // function ownerOf(uint256 tokenId) external view override returns (address) {}
    // function getApproved(uint256 tokenId) external view override returns (address) {}
    // function isApprovedForAll(address owner, address operator) external view override returns (bool) {}
    // function setApprovalForAll(address operator, bool approved) external override {}
    // function supportsInterface(bytes4 interfaceId) external view override returns (bool) {}
}
