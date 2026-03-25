// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";

contract DeployMinimal is Script {
    function run() external {
        vm.startBroadcast();
        vm.stopBroadcast();
    }
}
