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
    modifier SignerNotExist (address _signer) {
        bool signerFound;
        for(uint256 i; i < signers.length; i++){
            if(signers[i] == _signer){
                signerFound = true;
            }
        }
        
        require(!signerFound, "Signer Exists");
        _;
    }


    // transaction modifiers

    modifier TrxExist (uint256 trxId){
        require(trxId < transactions.length, "Trx Does Not Exist");
        _;
    }

    modifier NotApproved (uint256 trxId){
        require(!approved[trxId][msg.sender], "Trx Already Approved");
        _;
    }

    modifier NotExecuted (uint256 trxId){
        require(!transactions[trxId].executed, "Trx Already Executed");
        _;
    }
}
