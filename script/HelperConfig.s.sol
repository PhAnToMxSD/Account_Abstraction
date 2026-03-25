// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "lib/forge-std/src/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";

contract CONFIG is Script {
    error HELPERCONFIG__NOENTRYPOINTCONFIG();
    /* -------------------------------- constants ------------------------------- */
    uint256 constant ETH_SEP_CHAINID = 11155111;
    uint256 constant ANVIL_CHAINID = 31337; 
    uint256 constant ZK_SEP_CHAINID = 300; 
    address constant ACCOUNT = 0x787699751D6f39AA4C931478967594Bb7A5ca8df;  
    address constant ANVIL_ACC = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    /* --------------------------------- structs -------------------------------- */
    struct Config {
        address entryPoint;
        address acc;
    }
    /* --------------------------------- mapping -------------------------------- */
    mapping (uint256 => Config) public config;
    /* ------------------------------- constructor ------------------------------ */
    constructor () {
        config[ETH_SEP_CHAINID] = Config({
            entryPoint: 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789,
            acc: ACCOUNT
        });
        config[ZK_SEP_CHAINID] = Config({
            entryPoint: address(0),
            acc: ACCOUNT
        });
    }
    /* -------------------------------- functions ------------------------------- */
    Config public localConfig;

    function getConfigByChainID() view public returns (Config memory) {
        if (block.chainid == ETH_SEP_CHAINID) {
            return getSepoliaConfig();
        }
        else if (block.chainid == ANVIL_CHAINID){
            return getOrCreateAnvilConfig();
        }
        else if (block.chainid == ZK_SEP_CHAINID) {
            return getZKSepoliaConfig();
        }
        else {
            revert HELPERCONFIG__NOENTRYPOINTCONFIG();
        }
    }

    function getSepoliaConfig() public view returns (Config memory) {
        return config[ETH_SEP_CHAINID];
    }

    function getZKSepoliaConfig() public view returns (Config memory) {
        return config[ZK_SEP_CHAINID];
    }

    function getOrCreateAnvilConfig() public view returns (Config memory) {
        if (localConfig.entryPoint != address(0)) {
            return localConfig;
        }
        else {
            //To deploy a mock contract, will be done later
            return Config({
                entryPoint: address(0),
                acc: ANVIL_ACC
            });
        }
    }
}