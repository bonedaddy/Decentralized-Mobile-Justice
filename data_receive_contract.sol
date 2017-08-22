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

contract SafeMath {
      function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}


contract DataReceive is Owner, SafeMath {

    
    address public tokenContractAddress;

    struct Entry {
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
        bytes32[] ipfsHashes;
        bytes32[] ipfsChecksum;
    }

    // Used to keep trtack of  each uploader, how many videos they uploded, how many credits, etc...
    mapping (address => Uploaders) public uploaderTracker;
    
    // used to keep track of entries. Each IPFS hash when entered is set to true
    // This is used so that once an ipfsHash has been entered it can't be changed 
    mapping (string => bool) public ipfsHashEntered;

    // used to check if a user has uploaded before
    mapping (address => bool) public hasUploaded;
  
    // tracks credits of user 
    mapping (address => uint256) public creditBalances;

    // mapping used to track checksum to ipfshash
    mapping (string => string) public ipfshashToChecksum;

    // Event to log data entry
    event DataEntry(address indexed _recorder, string indexed _ipfsHash, string indexed _ipfsChecksum);
  
    // Logs a token transfer
    event CreditTransfer(address indexed _this, address indexed _to, uint256 _amount);
    // this function can only be called by the contract when a user hasn't uploaded before

    function registerRecorder(address _recorder) private {
        Uploaders memory t;
        t.person = _recorder;
        t.numContributions = 0;
        t.credits = 0;
        uploaderTracker[_recorder] = t;
    }
    function addEntry(address _recorder, string _ipfsHash) external {
        if(hasUploaded[_recorder]) {
           revert();
        } else {
            // user has n ever uploaded so lets register
            registerRecorder(_recorder);
        }
        // checks to see that this particular ipfs hash hasn't been uploaded before
        require(!ipfsHashEntered[_ipfsHash]);
        // makes sure the person calling the function isn't the recorder
        require(_recorder != msg.sender);
        uploaderTracker[_recorder].numContributions += 1; 
        uploaderTracker[_recorder].credits += 1; 
        // updates the `contributions` mapping which points to a struct
        uploaderTracker[_recorder].ipfsHashes.push(sha3(_ipfsHash)); 
        uploaderTracker[_recorder].ipfsHashes.push(sha3(_ipfsHash)); 
        if(!hasUploaded[_recorder]) {
            hasUploaded[_recorder] = true;
        }
        // Notifies blockchain that data was sotred
        DataEntry(_recorder, _ipfsHash, _ipfsChecksum);
    }

    function DataReceive(string _ipfsHash, address _tokenContractAddress) {
        uploaderTracker[msg.sender] = Uploaders(msg.sender,0, 0);
        Uploaders storage u = uploaderTracker[msg.sender];
        u.numContributions += 1;
        u.credits = 0;
        string ipfsChecksum = sha3(_ipfsHash); // we do checksum generation on chain
        u.contributions = Entry({id: u.numContributions, ipfsHash: _ipfsHash, ipfsChecksum: ipfsChecksum});
        ipfsHashEntered[_ipfsHash] = true;
        creditBalances[msg.sender] = 1; // temporary
    }

    function getIpfsHashChecksum(string _ipfsHash) constant returns (string _checksum) {
        return ipfshashToChecksum[_ipfsHash];
    }

    function verifiyDataIntegrity() constant returns (bool success) {
        return true;
    }

    function() payable {
        assert(msg.value == 0);
    }
 }