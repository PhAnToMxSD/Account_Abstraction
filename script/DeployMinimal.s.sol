// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";
import {CONFIG} from "./HelperConfig.s.sol";

contract DeployMinimal is Script {
    function run() external {
    }
    function deployMinimalAccount() external returns (CONFIG, MinimalAccount){
        CONFIG fig = new CONFIG();
        CONFIG.Config memory config = fig.getConfigByChainID();

        vm.startBroadcast();
        MinimalAccount minimal = new MinimalAccount(config.entryPoint);
        minimal.transferOwnership(msg.sender);
        vm.stopBroadcast();
        return (fig, minimal);
    }
}
