pragma solidity ^0.4.11;

// this will be a basic token used for the crowdfunding and will have no real use.
// Once the crowdfunding is over the token will be cloaned and given to the backers.ontract Owner {

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

contract icoToken is SafeMath, Owner {

    string name;
    string symbol;
    uint8 decimals;

    uint256 public _totalSupply;

    bool public crowdfundingOver;
    bool public crowdfundingStarted;

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

    mapping (address => uint256) public balances; // will keep track of balances

    modifier onlyDuringIco() {
        assert(crowdfundingStarted);
        _;
    }
    modifier preICO() {
        require(!crowdfundingOver);
        _;
    }    

    function icoToken(uint256 _amountMint, string _name, string _symbol, uint8 _decimals) {
        _totalSupply = add(_totalSupply, _amountMint);
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        crowdfundingOver = false;
        balances[msg.sender] = _totalSupply;
    }


    function transfer(address _to, uint256 _amount) onlyDuringIco returns (bool success) {
        require(_amount > 0);
        assert(_to != msg.sender);

    }

    // used to start the ICO
    function startIco() onlyOwner {
        require(!crowdfundingStarted);
        crowdfundingStarted = true;
    }
    // this function is to only run once the crowwdfunding is over


}