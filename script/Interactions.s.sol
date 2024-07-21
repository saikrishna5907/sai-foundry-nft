// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {SaiNFT} from "../src/SaiNFT.sol";
import {MoodNFT} from "../src/MoodNft.sol";

contract MintSaiNFT is Script {
    string public constant saiNFTURI =
        "ipfs://bafybeicv5l4y4la3v6yzgrl5f4ytsfp24smurojwiluykjit6nvlsqspti/";

    function run() external {
        address mostRecentlyDeployedNftContract = DevOpsTools
            .get_most_recent_deployment("SaiNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployedNftContract);
    }

    function mintNFTOnContract(address nftContract) public {
        vm.startBroadcast();
        SaiNFT(nftContract).mintNFT(saiNFTURI);
        vm.stopBroadcast();
    }
}

contract MintMoodNFT is Script {
    function run() external {
        address mostRecentlyDeployedNftContract = DevOpsTools
            .get_most_recent_deployment("MoodNFT", block.chainid);
        mintNFTOnContract(mostRecentlyDeployedNftContract);
    }

    function mintNFTOnContract(address nftContract) public {
        vm.startBroadcast();
        MoodNFT(nftContract).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNFT is Script {
    uint256 private constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedNftContract = DevOpsTools
            .get_most_recent_deployment("MoodNFT", block.chainid);
        flipMoodOnContract(mostRecentlyDeployedNftContract);
    }

    function flipMoodOnContract(address nftContract) public {
        vm.startBroadcast();
        MoodNFT(nftContract).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
