// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.9.0;
pragma experimental ABIEncoderV2;

import "./Lego.sol";

struct Owners {
    string ownerName;
    uint256 balance;
    mapping(address => Lego) legos;
}
