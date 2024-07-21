// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeploySaiNFT} from "../../script/DeploySaiNFT.s.sol";
import {SaiNFT} from "../../src/SaiNFT.sol";

contract SaiNFTIntegrationTest is Test {
    DeploySaiNFT saiNFTDeployer;
    SaiNFT saiNFT;
    address public user = makeAddr("user");

    string public constant shibaInuURI = "ipfs://bafybeia5uwb5zhd2ha5geosw2sj3g7ojzl2mzrdqnft73zebotsmc7fm34/";

    function setUp() public {
        // Deploy SaiNFT
        saiNFTDeployer = new DeploySaiNFT();
        saiNFT = saiNFTDeployer.run();
    }

    modifier setUpUserAndMintTokenURI() {
        vm.prank(user);
        saiNFT.mintNFT(shibaInuURI);
        _;
    }

    function testMintNFT() public setUpUserAndMintTokenURI {
        assert(saiNFT.balanceOf(user) == 1);
        assert(keccak256(abi.encodePacked(saiNFT.tokenURI(0))) == keccak256(abi.encodePacked(shibaInuURI)));
        assert(saiNFT.getTokenCounter() == 1);
    }
}
