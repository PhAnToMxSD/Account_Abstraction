// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {DeployMinimal} from "../script/DeployMinimal.s.sol";
import {CONFIG} from "../script/HelperConfig.s.sol";
import {MinimalAccount} from "../src/MinimalAccount.sol";
import {ERC20Mock} from "@openzeppelin/mocks/token/ERC20Mock.sol";

contract MinimalTest is Test {
    CONFIG fig;
    MinimalAccount min;
    ERC20Mock token;
    function setUp () public {
        DeployMinimal dep = new DeployMinimal();
        (fig, min) = dep.deployMinimalAccount();
        token = new ERC20Mock();
    }

    function testOwnerCanTransferFunds() public {
        address recipient = address(0x123);
        uint256 amount = 1 ether;
        vm.deal(address(min), 10 ether);
        min.execute(recipient, amount, "");
        assertEq(recipient.balance, amount);
    }

    function testOwnerCanExecuteCommands() public {
        assertEq(token.balanceOf(address(this)), 0);
        token.mint(address(min), 100);
        bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", address(this), 50);
        min.execute(address(token), 0, data);
        assertEq(token.balanceOf(address(this)), 50);
    }

    function testNonOwnerCannotExecute() public {
        address recipient = address(0x123);
        uint256 amount = 1 ether;
        vm.deal(address(min), 10 ether);
        vm.prank(address(0x456));
        vm.expectRevert();
        min.execute(recipient, amount, "");
    }
}