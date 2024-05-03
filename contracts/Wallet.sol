//  SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract MultisigWallet {
    address owner;
    mapping(address => bool) private signers;
    uint8 signersCount = 0;

    event SignerCreated(address Signer, uint8 signersCount);
    event SignerChanged(address _oldSigner, address _newSigner, uint8 signersCount);
    event SignerRemoved(address Signer, uint8 signersCount);


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
}