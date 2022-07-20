// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ERC721.sol";

contract ContractTest is Test {
    ERC721 erc721;
    address bob = address(0x1);
    address mary = address(0x2);

    function testMintToken() public {
        erc721 = new ERC721();
        erc721.mint(bob, 0);
        address owner_of = erc721.ownerOf(0);
        assertEq(owner_of, bob);
    }

    function testTransferToken() public {
        erc721 = new ERC721();
        erc721.mint(bob, 0);
        vm.startPrank(bob);
        erc721.transferFrom(bob, mary, 0);
        vm.stopPrank();(bob);

        assertEq(erc721.ownerOf(0), mary);
    }

    function testGetBalance() public {
        erc721 = new ERC721();
        erc721.mint(bob, 0);
        erc721.mint(bob, 1);
        erc721.mint(bob, 2);
        erc721.mint(bob, 3);
        erc721.mint(bob, 4);
        assertEq(erc721.balanceOf(bob), 5);
    }

    function testOnlyOwnerBurn() public {
        erc721 = new ERC721();
        erc721.mint(bob, 0);
        erc721.mint(bob, 1);
        vm.startPrank(mary);
        vm.expectRevert("not token owner");
        erc721.burn(1);
        vm.stopPrank();(mary);
    }
}
