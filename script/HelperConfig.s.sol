// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "lib/forge-std/src/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";

contract DeployMinimal is Script {
    /* --------------------------------- structs -------------------------------- */
    struct Config {
        address entryPoint;

    }
    mapping (uint256 => Config) public config;

    constructor () {
    }
}