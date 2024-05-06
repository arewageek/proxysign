//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Modifiers.sol";
import "./GlobalData.sol";

contract MultisigWallet is GlobalData, Modifiers{
    
    constructor(address _owner, uint8 _maxSignersCount, uint8 _requiredApprovals, address[] memory _signers){
        owner = _owner;
        maxSignersCount = _maxSignersCount;
        requiredApprovals = _requiredApprovals;

        require(signers.length > 0 && signers.length <= requiredApprovals, "Invalid number of signers");
        
        bool signerFound;
        for(uint8 i = 0; i < _signers.length; i++){
            // prevent use of dead or origin address
            require(_signers[i] != address(0) , "Invalid address");
            
            signers.push(_signers[i]);
        }

    }

    function CreateSigner(address _signer) public OnlyOwner SignerNotExist(_signer) returns(bool){
        signers.push(_signer);
        emit SignerCreated(_signer, signers.length);
        return true;
    }

    function changeSigner (address _newSigner, address _oldSigner) public OnlyOwner returns (bool){

        require(signers[_oldSigner], "Signer Not Exist");

        delete signers[_oldSigner];
        signers[_newSigner] = true;

        emit SignerChanged(_oldSigner, _newSigner, signers.length);

        return true;
    }
    
    function removeSigner (address _oldSigner) public OnlyOwner() SignerNotExist(_oldSigner) returns (bool){
        delete signers[_oldSigner];

        emit SignerRemoved(_oldSigner, signers.length);

        return true;
    }

    function setRequiredApprovals(uint8 newRequiredApprovals) public OnlyOwner() {
        requiredApprovals = newRequiredApprovals;
    }
    
    function approve(uint256 trxId) external OnlyOwner TransactionExecuted(trxId) NotApproved(trxId) NotExecuted(trxId) returns (bool){
        approved[trxId][msg.sender] = true;

        emit Approved (msg.sender, trxId);
    }

    function _getApprovalCount(uint256 trxId) private view returns(uint count){
        for(uint i=0; i<signers.length; i++){
            if(approved[trxId][signers[i]]){
                count++;
            }
        }
    }

    function execute(uint256 trxId) external TrxExist(trxId) NotExecuted(trxId){
        require(_getApprovalCount(trxId) >= requiredApprovals, "Approvals below requirement");
        Transaction storage transaction = transactions[trxId];

        transaction.executed = true;

        ( bool success ) = transaction.to.call{ value: transaction.value}(
            transaction.data
        );

        require(success, "Trx faied");

        emit Executed(trxId);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function getTokenBalance(address _token) external view returns(uint){
        IERC20 token = IERC20(_token);
        
        uint balance = token.balanceOf(msg.sender);

        return balance;
    }

    function submit(address _to, uint value, bytes calldata _data) external OnlyOwner{
        transactions[transactions.length] = Transaction({
            to: _to,
            amount: value,
            data: _data,
            exceeded: false
        });

        emit Submit(transactions.length - 1);
    }

    function revoke(uint256 trxId) external OnlyOwner TrxExist(trxId) NotExecuted(trxId){
        require(approved[trxId][msg.sender], "trx not approved");
        approved[trxId][msg.sender] = false;

        emit Revoke(trxId);
    }
}