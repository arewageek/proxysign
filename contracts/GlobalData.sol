// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract GlobalData{
    address owner;
    address[] signers;

    uint8 maxSignersCount;
    uint8 requiredApprovals;

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
    }

    mapping(uint256 => mapping(address => bool)) approved;

    Transaction[] public transactions;

    event SignerCreated(address Signer, uint8 signersCount);
    event SignerChanged(address _oldSigner, address _newSigner, uint8 signersCount);
    event SignerRemoved(address Signer, uint8 signersCount);
    event TransactionSigned(uint trxid, address signer);


    event Withdrawal(address indexed recipient, uint256 amount);
    event TransactionApproved(uint256 indexed transactionId);
    event TransactionExecuted(uint256 indexed transactionId);

    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 transactionId);
    event Approved(address indexed signer, uint256 indexed trxId);
    event Revoke(address indexed signer, uint256 indexed trxId);
    event Executed(uint256 trxId);
    
}