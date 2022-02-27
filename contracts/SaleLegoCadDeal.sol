// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LegoCadDeal.sol";

contract SaleLegoCadDeal {
    LegoCadDeal public legoCadDealAddress;

    constructor(address _legoCadDealAddress) {
        legoCadDealAddress = LegoCadDeal(_legoCadDealAddress);
    }

    mapping(uint256 => uint256) public tokenPrice;
    uint256[] public onSaleTokens;

    function setTokenPrice(uint256 _tokenId, uint256 _price) public {
        require(_price > 0, "1");
        require(tokenPrice[_tokenId] == 0, "2");

        address legoCadDealOwner = legoCadDealAddress.ownerOf(_tokenId); // ID에 해당하는 토큰의 주인 체크

        require(legoCadDealOwner == msg.sender, "3"); // 토큰의 주인과 함수를 실행한 사람이 같은지 체크
        require(
            legoCadDealAddress.isApprovedForAll(
                legoCadDealOwner,
                address(this)
            ),
            "4"
        );

        tokenPrice[_tokenId] = _price;
        onSaleTokens.push(_tokenId);
    }

    function purchaseToken(uint256 _tokenId) public payable {
        // require(onSaleTokens[_tokenId] == true, "5");
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

        // onSaleTokens[_tokenId] = false;
        tokenPrice[_tokenId] = 0;
        for (uint256 i = 0; i < onSaleTokens.length; i++) {
            if (tokenPrice[onSaleTokens[i]] == 0) {
                onSaleTokens[i] = onSaleTokens[onSaleTokens.length - 1];
                onSaleTokens.pop();
            }
        }
    }

    function getOnSaleTokensLength() public view returns (uint256) {
        return onSaleTokens.length;
    }
}
