// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC2981} from "@openzeppelin/contracts/token/common/ERC2981.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {FounderArt} from "./FounderArt.sol";

/// @title Youcognito Founder's Medal (1 of 1)
/// @notice Mints token #1 to `recipient` in the constructor. No owner, no other mint path,
///         no burn, no admin. Art and metadata are fully on-chain and immutable.
contract FounderMedal is ERC721, ERC2981 {
    uint256 public constant MAX_SUPPLY = 1;

    /// @param recipient token #1 receiver (plain _mint: works for smart wallets too)
    /// @param royaltyReceiver 5% ERC-2981 royalty receiver; address(0) = no royalty
    constructor(address recipient, address royaltyReceiver) ERC721("Youcognito Founder's Medal", "YCFOUNDER") {
        if (royaltyReceiver != address(0)) _setDefaultRoyalty(royaltyReceiver, 500);
        _mint(recipient, 1);
    }

    function totalSupply() external pure returns (uint256) { return 1; }

    function tokenURI(uint256 id) public view override returns (string memory) {
        _requireOwned(id);
        string memory json = string.concat(
            '{"name":"Youcognito Founder\'s Medal #1","description":"The one and only Youcognito Founder\'s Medal. 1 of 1, minted on Base. Art stored fully on-chain.",',
            '"image":"data:image/svg+xml;base64,', Base64.encode(bytes(FounderArt.SVG)),
            '","attributes":[{"trait_type":"Edition","value":"1/1"},{"trait_type":"Role","value":"Founder"}]}'
        );
        return string.concat("data:application/json;base64,", Base64.encode(bytes(json)));
    }

    function supportsInterface(bytes4 i) public view override(ERC721, ERC2981) returns (bool) {
        return super.supportsInterface(i);
    }
}
