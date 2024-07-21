// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    error MoodNFT__OnlyOwnerCanFlipMood();

    uint256 private s_tokenCounter;
    string private s_sadSvgUri;
    string private s_happySvgUri;
    address private immutable i_contractOwner;

    enum Mood {
        SAD,
        HAPPY
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgBase64,
        string memory happySvgBase64
    ) ERC721("MoodNFT", "MNFT") {
        s_tokenCounter = 0;
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_sadSvgUri = sadSvgBase64;
        s_happySvgUri = happySvgBase64;
        i_contractOwner = msg.sender;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            imageURI = s_sadSvgUri;
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                "{",
                                '"name":',
                                '"',
                                name(),
                                '",',
                                '"description":',
                                '"',
                                "An NFT that shows the owner mood.",
                                '",',
                                '"attributes":',
                                '[{"trait_type": "moodiness", "value": 100}],',
                                '"image":',
                                '"',
                                imageURI,
                                '"',
                                "}"
                            )
                        )
                    )
                )
            );
    }

    function flipMood(uint256 tokenId) public {
        if (!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)) {
            revert MoodNFT__OnlyOwnerCanFlipMood();
        }

        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        } else if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        }
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
