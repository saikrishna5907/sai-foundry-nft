// SPDX-Licence-Identifier: MIT

pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeploySaiNFT} from "../../script/DeploySaiNFT.s.sol";
import {SaiNFT} from "../../src/SaiNFT.sol";

contract SaiNFTTest is Test {
    SaiNFT saiNFT;
    address public user = makeAddr("user");

    string public constant shibaInuURI =
        "ipfs://bafybeia5uwb5zhd2ha5geosw2sj3g7ojzl2mzrdqnft73zebotsmc7fm34/";

    function setUp() public {
        saiNFT = new SaiNFT();
    }

    modifier setUpUserAndMintTokenURI() {
        vm.prank(user);
        saiNFT.mintNFT(shibaInuURI);
        _;
    }

    function testNameIsCorrect() public view {
        assert(
            keccak256(abi.encodePacked(saiNFT.name())) ==
                keccak256(abi.encodePacked("SaiNFT"))
        );

        assert(
            keccak256(abi.encodePacked(saiNFT.symbol())) ==
                keccak256(abi.encodePacked("SAINFT"))
        );
    }

    function testInitialTokenCounter() public view {
        assert(saiNFT.getTokenCounter() == 0);
    }
}
