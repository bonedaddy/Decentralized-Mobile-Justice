pragma solidity ^0.4.14;

contract IpfsControls {

    struct IpfsEntries {
        string ipfsHash;
    }


    // used to track that an entry was made
    mapping (uint => IpfsEntries) public ipfsEntryTracker;
    
    event PublishHash(string indexed identifier, bytes32 indexed shaIpfsHash);

    modifier onlyOnce(string _identifier, bytes32 _ipfsHash) {
        require(!ipfsEntryTracker[_identifier][_ipfsHash]);
        _;
    }

    function IpfsControls() {
        // constructor, claled during function init
        // points to a readme file
        ipfsEntryTracker[0] = IpfsEntries("QmbFMke1KXqnYyBBWxB74N4c5SBnJMVAiMNRcGu6x1AwQH");
    }

    function updateMappings( bytes32 _ipfsHash) internal {
    }
    // this sets a particular hash on the blockchain, bound to a mapping.
    function uploadHash(string _identifier, bytes32 _ipfsHash) public {
        updateMappings(_identifier, _ipfsHash);
        if(!ipfsEntryTracker[_identifier][_ipfsHash]) {
            revert();
        }
    }

    function getFile(string _dataName) constant returns (bytes32) {
        return ipfsEntries[_dataName];
    }

 
}

contract SecurityControls {

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    } 
    function SecurityControls() {
        owner = msg.sender;
    }

    function transferOwnership(address _newOwner) public onlyOwner returns (bool success) {
        owner = _newOwner;
        return true;
    }
}

contract PoliceEnforcement is ipfsControls, SecurityControls {

    address public privilegedAccount;

    function PoliceEnforcement() {
        privilegedAccount = msg.sender; // temporary
    }

    function publishVideo(string _identifier, bytes32 _ipfsHash) returns (bool success) {
        uploadHash(_identifier,sha3(_ipfsHash,block.timestamp));
        return true;
    } 
}