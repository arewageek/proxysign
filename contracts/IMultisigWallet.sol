// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface IMultiSigWallet {
    function transferERC20(address token, address to, uint256 amount) external returns (bool);
    function approveTransaction(uint256 transactionId) external returns (bool);
    function executeTransaction(uint256 transactionId) external returns (bool);

    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed recipient, uint256 amount);
    event TransactionApproved(uint256 indexed transactionId);
    event TransactionExecuted(uint256 indexed transactionId);
}