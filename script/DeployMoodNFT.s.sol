// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    string private _sadSvg;
    string private _happySvg;

    function getLocalSadSVG() private view returns (string memory) {
        return vm.readFile("./images/sad.svg");
    }

    function getLocalHappySVG() private view returns (string memory) {
        return vm.readFile("./images/happy.svg");
    }

    function initialize(string memory sadSvg, string memory happySvg) public {
        _sadSvg = sadSvg;
        _happySvg = happySvg;
    }

    function run() public returns (MoodNFT) {
        // Deploy MoodNFT
        _sadSvg = getLocalSadSVG();
        _happySvg = getLocalHappySVG();

        vm.startBroadcast();
        MoodNFT moodNFT = new MoodNFT(svgToImageURI(_sadSvg), svgToImageURI(_happySvg));
        vm.stopBroadcast();

        return moodNFT;
    }

    function run(string memory sadSvg, string memory happySvg) public returns (MoodNFT) {
        initialize(sadSvg, happySvg);
        return run();
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory imageUriPrefix = "data:image/svg+xml;base64,";

        return string(abi.encodePacked(imageUriPrefix, Base64.encode(bytes(svg))));
    }
}
