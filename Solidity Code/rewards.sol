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

contract Rewards is SafeMath, Owner {

    address public founder;
    address public tokenContractAddress;
    bool public rewardsFrozen;
    // used to track credits
    mapping (address => uint256) public balances;

    // notify network of unfreeze
    event InitRewards(bool indexed enabled);

    function Rewards(address _tokenContractAddress) {
        founder = msg.sender;
        tokenContractAddress = _tokenContractAddress;
        rewardsFrozen = true;
    }

    function initializeRewardSystem(uint256 _tokenAmount) onlyOwner {
        // requires tokens sent to this contract first
        balances[owner] = _tokenAmount;
        rewardsFrozen = false;
        InitRewards(true);
    }


    function calcRewardStreamer(address _recorder) returns (bool success) {
        return true;
    }
}