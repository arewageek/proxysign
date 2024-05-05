// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./GlobalData.sol";

contract Modifiers is GlobalData {
    // authorization modifiers
    modifier OnlyOwner() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }

    // signers validation modifiers
    modifier SignerExist (address _signer) {
        require(!signers[_signer], "Duplicate Entry");
        _;
    }

    modifier SignerNotExist (address _signer){
        require(signers[_signer], "Signer Not Exist");
        _;
    }


    // transaction modifiers

    modifier TransactionExist (uint256 trxId){
        require(trxId < nextTrxId, "Transaction Exist");
        _;
    }

    modifier NotExceeded (uint256 trxId){
        require(!transactions[trxId].exceeded, "Transaction Already Executed");
        _;
    }
}
