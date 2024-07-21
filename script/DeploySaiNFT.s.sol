// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {SaiNFT} from "../src/SaiNFT.sol";

contract DeploySaiNFT is Script {
    function run() public returns (SaiNFT) {
        // Deploy SaiNFT
        vm.startBroadcast();
        SaiNFT saiNFT = new SaiNFT();
        vm.stopBroadcast();

        return saiNFT;
    }
}
