// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LegoCadDeal.sol";

contract SaleLegoCadDeal {
    LegoCadDeal public legoCadDealAddress;

    mapping(uint256 => bool) onSale;
    mapping(uint256 => uint256) price;

    constructor(address _legoCadDealAddress) {
        legoCadDealAddress = LegoCadDeal(_legoCadDealAddress);
    }

    // 토큰 가격 책정
    function setPrice(uint256 _tokenId, uint256 _price) public {
        require(_price > 0, "");
        address tokenOwner = legoCadDealAddress.ownerOf(_tokenId);
        require(msg.sender == tokenOwner, "");
        price[_tokenId] = _price;
        onSale[_tokenId] = true;
    }

    // 토큰 구매
    function purchase(uint256 _tokenId) public payable {
        require(price[_tokenId] == msg.value, "");
        address tokenOwner = legoCadDealAddress.ownerOf(_tokenId);
        require(msg.sender != tokenOwner, "");
        require(
            legoCadDealAddress.isApprovedForAll(tokenOwner, msg.sender),
            ""
        );

        payable(tokenOwner).transfer(msg.value);
        legoCadDealAddress.safeTransferFrom(tokenOwner, msg.sender, _tokenId);

        price[_tokenId] = 0;
        onSale[_tokenId] = false;
    }
}
