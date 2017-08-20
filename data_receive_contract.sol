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




    // used to keep track of entries. Each IPFS hash when entered is set to true
    // This is used so that once an ipfsHash has been entered it can't be changed 
    mapping (string => bool) public ipfsHashEntered;

    // tracks number of contributions for a given identity
    mapping (address => uint256) public contributionTracker;

    // used to check if a user has uploaded before
    mapping (address => bool) public hasUploaded;

    struct Entry {
        uint256 id;
        string hash;
    }

    // testing struct to track user entries
    struct Uploaders {
        address person;
        uint256 numContributions;
        // unused for now, will be used to track credits;
        uint256 credits;
        // each time  a user makes an upload, the key gets upped by 1, with a new value of the ipfs hash
        mapping (uint256 => Entry) contributions;
    }
    // Used to keep trtack of  each uploader, how many videos they uploded, how many credits, etc...
    mapping (address => Uploaders) public uploaderTracker;
    
    // this function can only be called by the contract when a user hasn't uploaded before
    function initializeFirstEntry() private {
        
    }

    function addEntry(address _recorder, string _ipfsHash, string _ipfsChecksum) external {
        if(!hasUploaded) {
            initializeFirstEntry(_recorder);
        }
        require(!ipfsHashEntered[_ipfsHash]);
        require(_recorder != msg.sender);
        contributionTracker[_recorder] += 1;        
        ipfsTracker[_ipfsHash] = _ipfsChecksum;
        ipfsHashEntered[_ipfsHash] = true;
        DataEntry(_recorder, _ipfsHash, _ipfsChecksum);
    }


    // Event to log data entry
    event DataEntry(address indexed _recorder, string indexed _ipfsHash, string indexed _ipfsChecksum);

    function DataReceive(string _ipfsHash, string _ipfsChecksum) {
        ipfsTracker[_ipfsHash] = _ipfsChecksum;
        ipfsHashEntered[_ipfsHash] = true;
    }

    function getIpfsHashChecksum(string _ipfsHash) constant returns (string _checksum) {
        return ipfsTracker[_ipfsHash];
    }

    function getIpfsHash()
    function getContributionCount(address _person) constant returns (uint256 _amount) {
        if(contributionTracker[_person] <= 0) {
            return 0;
        } else {
            return contributionTracker[_person];    
        }
    }


 
    function verifiyDataIntegrity() constant returns (bool success) {
        return true;
    }
 }