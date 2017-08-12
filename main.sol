pragma solidity ^0.4.14;

contract ipfsControls {
     // used to generate, and store, the hash on the blockchain and also store the file on the ipfs node
     // also used for returning the  ipfs hash
    bytes storedData;

    mapping (string => bytes32) public ipfsEntries;    

    // this sets a particular hash on the blockchain, bound to a mapping.
    function setHash(string _dataName, bytes32 _data) {
        ipfsEntries[_dataName] = _data;
    }

    function getHash(string _dataName) constant returns (bytes32) {
        return ipfsEntries[_dataName];
    }

}


contract PoliceEnforcement {

    
}