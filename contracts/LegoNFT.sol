// SPDX-License-Identifier: MIT
pragma solidity >=0.4.24 <=0.9.0;

/* is ERC165 */
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

    // function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) public ;
    // function safeTransferFrom(address _from, address _to, uint256 _tokenId) public ;
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;
    // function approve(address _approved, uint256 _tokenId) public ;
    // function setApprovalForAll(address _operator, bool _approved) public;
    // function getApproved(uint256 _tokenId) public view returns (address);
    // function isApprovedForAll(address _owner, address _operator) public view returns (bool);
}

contract LegoNFT is ERC721 {
    mapping(uint256 => address) LegoOwner;
    mapping(address => uint256) ownedLegoCounts;
    mapping(address => bool) ownedLegoPrint;

    function mint(address _to, uint256 _legoId) public {
        LegoOwner[_legoId] = _to;
        ownedLegoCounts[_to] += 1;
        ownedLegoPrint[_to] = true;
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        return ownedLegoCounts[_owner];
    }

    function ownerOf(uint256 _legoId) public view override returns (address) {
        return LegoOwner[_legoId];
    }

    function ownerOfLegoPrint(address _owner) public view returns (bool) {
        return ownedLegoPrint[_owner];
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _legoId
    ) public override {
        address owner = ownerOf(_legoId);
        require(msg.sender == owner);
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
