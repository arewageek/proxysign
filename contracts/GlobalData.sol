// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract GlobalData{
    address owner;
    mapping(address => bool) signers;
    uint8 signersCount = 0;

    struct Transaction {
        address to;
        uint256 amount;
        bool exceeded;
        address[] signers;
    }

    mapping(uint256 => Transaction) public transactions;
    uint256 public nextTrxId;

    event SignerCreated(address Signer, uint8 signersCount);
    event SignerChanged(address _oldSigner, address _newSigner, uint8 signersCount);
    event SignerRemoved(address Signer, uint8 signersCount);
    event TransactionSigned(uint trxid, address signer);
}