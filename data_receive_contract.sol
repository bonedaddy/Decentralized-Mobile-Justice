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

    mapping (uint256 => bytes32) public ipfsTracker;

    function DataReceive(uint256 _someidentifier, string _ipfsHash) {
        ipfsTracker[_someidentifier] = sha3(_ipfsHash);
    }
}