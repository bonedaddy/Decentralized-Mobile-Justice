pragma solidity ^0.4.14;


contract StringAsKey {
    function convert(string key) returns (bytes32 ret) {
        if (bytes(key).length > 32) {
            revert();
        }

        assembly {
            ret := mload(add(key, 32))
        }
    }
}
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


contract DataReceive is Owner, SafeMath, StringAsKey {

    
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
        string[] ipfsHashes;
        bytes32[] ipfsChecksum;
    }

    // Used to keep trtack of  each uploader, how many videos they uploded, how many credits, etc...
    mapping (address => Uploaders) public uploaderTracker;
    
    // used to keep track of entries. Each IPFS hash when entered is set to true
    // This is used so that once an ipfsHash has been entered it can't be changed 
    mapping (string => bool) ipfsHashEntered;

    // used to check if a user has uploaded before
    mapping (address => bool) public hasUploaded;
  
    // tracks credits of user 
    mapping (address => uint256) public creditBalances;

    // mapping used to track checksum to ipfshash
    mapping (string => string)  ipfshashToChecksum;

    // Event to log data entry
    event DataEntry(address indexed _recorder, string indexed _ipfsHash, bytes32 indexed _ipfsChecksum);
  
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
        bytes32 checksum = sha3(_ipfsHash);
        uploaderTracker[_recorder].numContributions += 1; 
        uploaderTracker[_recorder].credits += 1; 
        // updates the `contributions` mapping which points to a struct
        uploaderTracker[_recorder].ipfsHashes.push(_ipfsHash); 
        uploaderTracker[_recorder].ipfsChecksum.push(checksum); 
        if(!hasUploaded[_recorder]) {
            hasUploaded[_recorder] = true;
        }
        // Notifies blockchain that data was sotred
        DataEntry(_recorder, _ipfsHash, checksum);
    }

    function DataReceive(address _tokenContractAddress) {
        Uploaders memory t;
        t.person = msg.sender;
        t.numContributions = 0;
        t.credits = 0;
        uploaderTracker[msg.sender] = t;
        tokenContractAddress = _tokenContractAddress;
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