// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LegoCadDeal.sol";

contract SaleLegoCadDeal {
    LegoCadDeal public legoCadDealAddress;

<<<<<<< HEAD
    mapping(uint256 => bool) onSaleToken;
    mapping(uint256 => uint256) public tokenPrice;
=======
    mapping(uint256 => bool) onSale;
    mapping(uint256 => uint256) price;
>>>>>>> a006635aa343fac8f4d3929a2707d9f54ac2de97

    constructor(address _legoCadDealAddress) {
        legoCadDealAddress = LegoCadDeal(_legoCadDealAddress);
    }

<<<<<<< HEAD
    function setTokenPrice(uint256 _tokenId, uint256 _price) public {
        require(_price > 0, "1");
        require(tokenPrice[_tokenId] == 0, "2");

        address legoCadDealOwner = legoCadDealAddress.ownerOf(_tokenId);

        require(legoCadDealOwner == msg.sender, "3");
        require(
            legoCadDealAddress.isApprovedForAll(
                legoCadDealOwner,
                address(this)
            ),
            "4"
        );

        tokenPrice[_tokenId] = _price;
        onSaleToken[_tokenId] = true;
    }

    function purchaseToken(uint256 _tokenId) public payable {
        require(onSaleToken[_tokenId] == true, "5");
        require(tokenPrice[_tokenId] > 0, "6");

        address legoCadDealOwner = legoCadDealAddress.ownerOf(_tokenId);
        require(legoCadDealOwner != msg.sender, "7");

        uint256 price = tokenPrice[_tokenId];
        require(msg.value == price, "8");

        payable(legoCadDealOwner).transfer(msg.value);
        legoCadDealAddress.safeTransferFrom(
            legoCadDealOwner,
            msg.sender,
            _tokenId
        );

        onSaleToken[_tokenId] = false;
        tokenPrice[_tokenId] = 0;
=======
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
>>>>>>> a006635aa343fac8f4d3929a2707d9f54ac2de97
    }
}
