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

    struct Entry {
        uint256 id; // entry number
        string ipfsHash; // name of ipfs hash
        string ipfsChecksum; // name of checksum
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
    
    // used to keep track of entries. Each IPFS hash when entered is set to true
    // This is used so that once an ipfsHash has been entered it can't be changed 
    mapping (string => bool) public ipfsHashEntered;

    // used to check if a user has uploaded before
    mapping (address => bool) public hasUploaded;
  
    // Event to log data entry
    event DataEntry(address indexed _recorder, string indexed _ipfsHash, string indexed _ipfsChecksum);
  
    // this function can only be called by the contract when a user hasn't uploaded before
    function initializeFirstEntry(address _recorder) private {
        // creates a brand new struct and saves it to storage.
        uploaderTracker[_recorder] = Uploaders(_recorder, 0, 0);
    }

    function addEntry(address _recorder, string _ipfsHash, string _ipfsChecksum) external {
        if(!hasUploaded[_recorder]) {
            initializeFirstEntry(_recorder);
        }
        // checks to see that this particular ipfs hash hasn't been uploaded before
        require(!ipfsHashEntered[_ipfsHash]);
        // makes sure the person calling the function isn't the recorder
        require(_recorder != msg.sender);
        Uploaders storage u = uploaderTracker[_recorder];
        u.numContributions += 1;
        u.credits += 22222; // arbitrary for now
        // updates the `contributions` mapping which points to a struct
        u.contributions = Entry({id: u.numContributions, ipfsHash: _ipfsHash, ipfsChecksum: _ipfsChecksum});
        if(!hasUploaded[_recorder]) {
            hasUploaded[_recorder] = true;
        }
        // Notifies blockchain that data was sotred
        DataEntry(_recorder, _ipfsHash, _ipfsChecksum);
    }

    function DataReceive(string _ipfsHash, string _ipfsChecksum) {
        uploaderTracker[msg.sender] = Uploaders(msg.sender,0, 0);
        Uploaders storage u = uploaderTracker[msg.sender];
        u.numContributions += 1;
        u.credits = 0;
        u.contributions = Entry({id: u.numContributions, ipfsHash: _ipfsHash, ipfsChecksum: _ipfsChecksum});
        ipfsTracker[_ipfsHash] = _ipfsChecksum;
        ipfsHashEntered[_ipfsHash] = true;
    }

    function getIpfsHashChecksum(string _ipfsHash) constant returns (string _checksum) {
        return ipfsTracker[_ipfsHash];
    }

    function verifiyDataIntegrity() constant returns (bool success) {
        return true;
    }
 }