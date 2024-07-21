// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNFT} from "../../script/DeployMoodNFT.s.sol";
import {MoodNFT} from "../../src/MoodNft.sol";

contract DeployMoodNFTTest is Test {
    DeployMoodNFT deployer;

    string private constant imageSVG =
        '<svg width="300" height="130" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="100" x="10" y="10" rx="20" ry="20" fill="blue" /></svg>';
    string private constant imageUri =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjEzMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMjAwIiBoZWlnaHQ9IjEwMCIgeD0iMTAiIHk9IjEwIiByeD0iMjAiIHJ5PSIyMCIgZmlsbD0iYmx1ZSIgLz48L3N2Zz4=";

    function setUp() public {
        deployer = new DeployMoodNFT();
        deployer.run();
    }

    function testSvgToImageURI() public view {
        string memory result = deployer.svgToImageURI(imageSVG);

        assert(
            keccak256(abi.encodePacked(result)) ==
                keccak256(abi.encodePacked(imageUri))
        );
    }
}
