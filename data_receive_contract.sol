pragma solidity ^0.4.11;


contract Owner {
    
    address public owner;

    function Owner() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) onlyOwner {
        owner = _newOwner;
    }
}
contract DataReceive is Owner {

    mapping (string => string) public ipfsTracker;
    mapping (string => bool) public ipfsHashEntered;


    function DataReceive(string _ipfsHash, string _ipfsChecksum) {
        ipfsTracker[_ipfsHash] = _ipfsChecksum;
        ipfsHashEntered[_ipfsHash] = true;
    }

    function getIpfsHashChecksum(string _ipfsHash) constant returns (string _checksum) {
        return ipfsTracker[_ipfsHash];
    }

    function addEntry(string _ipfsHash, string _ipfsChecksum) external {
        require(!ipfsHashEntered[_ipfsHash]);
        ipfsTracker[_ipfsHash] = _ipfsChecksum;
        ipfsHashEntered[_ipfsHash] = true;
    }
 
 }