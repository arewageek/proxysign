//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

<<<<<<< HEAD
import "./IMultisigWallet.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MultisigWallet is IMultiSigWallet{
=======
contract MultisigWallet {
>>>>>>> main
    address owner;
    mapping(address => bool) private signers;
    uint8 signersCount = 0;

<<<<<<< HEAD
    mapping(uint trxid => uint approvals) private trxApprovals;

    event SignerCreated(address Signer, uint8 signersCount);
    event SignerChanged(address _oldSigner, address _newSigner, uint8 signersCount);
    event SignerRemoved(address Signer, uint8 signersCount);
    event TransactionSigned(uint trxid, address signer);
=======
    event SignerCreated(address Signer, uint8 signersCount);
    event SignerChanged(address _oldSigner, address _newSigner, uint8 signersCount);
    event SignerRemoved(address Signer, uint8 signersCount);
>>>>>>> main


    constructor(address _owner){
        owner = _owner;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }
    
    modifier SignerExist (address _signer) {
        require(!signers[_signer], "Duplicate Entry");
        _;
    }

    modifier SignerNotExist (address _signer){
        require(signers[_signer], "Signer Not Exist");
        _;
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
<<<<<<< HEAD



    // erc20 transaction functions

    // erc20 modifiers

    // erc20 functions
    function transferERC20(address token, address to, uint256 amount) external returns (bool){        
        require(amount >= 0, "Invalid amount");
        require(IERC20(token).transfer(to, amount), "Transfer failed");
    }

    function approveTransaction(uint256 transactionId) external returns (bool){
        // check if already approved
        if(trxApprovals[transactionId] >= 3){
            
        }

        else{
            trxApprovals[transactionId] ++;

            emit TransactionSigned(transactionId, msg.sender);
            return true;
        }
    }

    function executeTransaction(uint256 transactionId) external returns (bool){

    }
=======
>>>>>>> main
}