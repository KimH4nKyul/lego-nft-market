// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LegoCadDeal.sol";

contract SaleLegoCadDeal {
    LegoCadDeal public legoCadDealAddress;

    mapping(uint256 => bool) onSaleToken;
    mapping(uint256 => uint256) public tokenPrice;
    uint256[] onSaleTokenIdList;

    constructor(address _legoCadDealAddress) {
        legoCadDealAddress = LegoCadDeal(_legoCadDealAddress);
    }

    function add(uint256 _tokenId, bool _value) public {
        onSaleToken[_tokenId] = _value;
        onSaleTokenIdList.push(_tokenId);
    }

    function contains(uint256 _tokenId) public view returns (bool) {
        return onSaleToken[_tokenId] != false;
    }

    function getByTokenId(uint256 _tokenId) public view returns (bool) {
        return onSaleToken[_tokenId];
    }

    function size() public view returns (uint256) {
        return uint256(onSaleTokenIdList.length);
    }

    function getTokenIds() public view returns (uint256[] memory) {
        return onSaleTokenIdList;
    }

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
    }
}
