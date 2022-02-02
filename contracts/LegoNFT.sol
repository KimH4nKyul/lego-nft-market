// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Lego.sol";
import "./Owners.sol";

interface ERC721 {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;
}

contract LegoNFT is ERC721 {
    mapping(uint256 => address) LegoOwner;
    mapping(address => uint256) ownedLegoCounts;
    mapping(address => bool) ownedLegoPrint;
    mapping(address => Lego[]) ownerToLego;
    mapping(address => Owners) owners;

    address owner;

    Lego[] public Legos;

    constructor() public payable {
        owner = msg.sender;
    }

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    function mint(
        string memory _legoName,
        string memory _img,
        string memory _description
    ) public returns (uint256) {
        Lego memory newLego = Lego(_legoName, _img, _description, msg.sender);
        Legos.push(newLego);
        uint256 legoId = Legos.length - 1;
        LegoOwner[legoId] = msg.sender;
        ownedLegoCounts[msg.sender] += 1;
        ownedLegoPrint[msg.sender] = true;
        return legoId;
    }

    function balanceOf(address _owner)
        public
        view
        override
        restricted
        returns (uint256)
    {
        return ownedLegoCounts[_owner];
    }

    function ownerOf(uint256 _legoId)
        public
        view
        override
        restricted
        returns (address)
    {
        return LegoOwner[_legoId];
    }

    function ownerOfLegoPrint(address _owner)
        public
        view
        restricted
        returns (bool)
    {
        return ownedLegoPrint[_owner];
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _legoId
    ) public override restricted {
        address owner = ownerOf(_legoId);
        require(_from != address(0));
        require(_to != address(0));

        ownedLegoCounts[_from] -= 1;
        LegoOwner[_legoId] = address(0);
        ownedLegoPrint[_from] = false;

        ownedLegoCounts[_to] += 1;
        LegoOwner[_legoId] = _to;
        ownedLegoPrint[_to] = true;
    }
}
