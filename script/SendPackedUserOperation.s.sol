// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {PackedUserOperation} from "lib/account-abstraction/contracts/interfaces/PackedUserOperation.sol";

contract SendUserUp is Script {
    function getSignedUserop(address sender, bytes memory _calldata) view public returns (PackedUserOperation memory) {
        PackedUserOperation memory userOp = _getUnsignedUserOp(
            sender,
            vm.getNonce(sender),  
            _calldata
        );
        bytes memory signature = hex"";
        userOp.signature = signature;
        return userOp;
    }

    function _getUnsignedUserOp(
        address _sender,
        uint256 _nonce,
        bytes memory _callData
    ) internal pure returns (PackedUserOperation memory userOp) {
        uint128 verificationGasLimit = 16777216;
        uint128 callGasLimit = verificationGasLimit; 
        uint128 maxPriorityFeePerGas = 256;
        uint128 maxFeePerGas = maxPriorityFeePerGas; 
        userOp = PackedUserOperation(
            _sender,
            _nonce,
            hex"",
            _callData,
            bytes32(uint256(verificationGasLimit) << 128 | uint256(callGasLimit)),
            verificationGasLimit,
            bytes32(uint256(maxPriorityFeePerGas) << 128 | uint256(maxFeePerGas)),
            hex"",
            hex""
        );
    }
}
