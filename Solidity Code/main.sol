pragma solidity ^0.4.11;

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

contract IpfsControls is SafeMath {

    struct IpfsEntries {
        string ipfsHash;
    }


    uint256 numEntries;

    // used to track that an entry was made
    mapping (uint => IpfsEntries) public ipfsEntryTracker;
    mapping (uint8 => bool) public ipfsEntered;    
    event PublishHash(string indexed identifier, bytes32 indexed shaIpfsHash);

    modifier onlyOnce(bytes32 _ipfsHash) {
        // need a way to keep 
        require(!ipfsEntered[0][_ipfsHash]);
        _;
    }

    function IpfsControls() {
        // constructor, claled during function init
        // points to a readme file
        ipfsEntryTracker[0] = IpfsEntries("QmbFMke1KXqnYyBBWxB74N4c5SBnJMVAiMNRcGu6x1AwQH");
        ipfsEntered[0] = true;
    }

    function updateMappings( bytes32 _ipfsHash) onlyOnce internal {
        numEntries = SafeMath(numEntries, 1); // need to implement safe math
        ipfsEntryTracker[numEntries] = IpfsEntries(_ipfsHash);
    }
    // this sets a particular hash on the blockchain, bound to a mapping.
    function uploadHash(string _identifier, bytes32 _ipfsHash) public {
        updateMappings(_identifier, _ipfsHash);
        if(!ipfsEntryTracker[_identifier][_ipfsHash]) {
            revert();
        }
    }

    function getFile(string _dataName) constant returns (bytes32) {
        // Eventually a searchable index will be made that can be used to view a list of hashes
        // This will then be expanded to keyword based categorization
        return ipfsEntryTracker[_dataName];
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