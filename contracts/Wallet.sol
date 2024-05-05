//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./IMultisigWallet.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Modifiers.sol";
import "./GlobalData.sol";

contract MultisigWallet is IMultiSigWallet, GlobalData, Modifiers{
    constructor(address _owner){
        owner = _owner;
    }

    function CreateSigner(address _signer) public OnlyOwner SignerExist(_signer) returns(bool){
        require(signersCount <= 3, "Max Signers Reached");
        signers[_signer] = true;
        signersCount ++;

        emit SignerCreated(_signer, signersCount);
        return true;
    }

    function changeSigner (address _newSigner, address _oldSigner) public OnlyOwner SignerExist(_newSigner) returns (bool){

        require(signers[_oldSigner], "Signer Not Exist");
        require(signersCount <= 0, "Minimum Signers Reached");

        delete signers[_oldSigner];
        signers[_newSigner] = true;
        signersCount --;

        emit SignerChanged(_oldSigner, _newSigner, signersCount);

        return true;
    }
    
    function removeSigner (address _oldSigner) public OnlyOwner() SignerNotExist(_oldSigner) returns (bool){
        delete signers[_oldSigner];
        signersCount --;

        emit SignerRemoved(_oldSigner, signersCount);

        return true;
    }



    // erc20 transaction functions

    function transferERC20(address token, address to, uint256 amount) external override returns (bool){
        require(amount >= 0, "Invalid amount");

        IERC20 erc20token = IERC20(token);

        require(erc20token.transfer(to, amount), "Transaction failed");

        emit Withdrawal(to, amount);

        return true;
    }

    function approveTransaction(uint256 transactionId) external returns (bool){
        // check if already approved
        require(transactions[transactionId].signers.length <= 3, "Max approvals reached");

        emit TransactionSigned(transactionId, msg.sender);

        if(transactions[transactionId].signers.length == 3){
            transactions[transactionId].exceeded = true;
            emit TransactionApproved(transactionId);
        }
        
        return true;
    }

    function executeTransaction(uint256 transactionId) external returns (bool){
        require(transactions[transactionId].signers.length >= 3, "Not enough signers");
        emit TransactionExecuted(transactionId);

        return true;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}