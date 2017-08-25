library SafeMath {

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

// Used for function invoke restriction
contract Owned {

    address public owner;

    function Owned() {
        owner = msg.sender;
    }

    modifier Owner() {
        if (msg.sender != owner)
            revert();
        _; // function code inserted here
    }

    function transferOwnership(address _newOwner) Owner returns (bool success) {
        if (msg.sender != owner)
            revert();
        owner = _newOwner;
        return true;
        
    }

}


contract DMG is Owned {


    
    using SafeMath for uint256;
    address public privilegedAddress; // defines a privileged address that can perform different actions
    address public realTokenAddr; 
    string public name = "Decentralized Mobile Jusitce ICO Token";
    string public symbol = "DMJIco";
    uint8 public decimals = 18;
    uint256 public _totalSupply = 1000000000000000000000000000;
    bool public tokensFrozen;

    // will store balance information
    mapping (address => uint256) public balances;
    // will store allowance approval information 
    mapping (address => mapping (address => uint256)) public allowed;
    // Used to keep track of individual account seizure


    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event Approval(address indexed _owner, address indexed _spender, uint256 _amount);
    event TokenFreeze(bool indexed Frozen); // network wide token freeze

    modifier onlyWhenFrozen() {
        require(tokensFrozen);
        _;
    }

    function  DMG() {
        tokensFrozen = false;
        balances[owner] = _totalSupply;
        tokensFrozen = true; // sets the default to frozen  to prevent anyone  altering data
    }


    function unfreezeTokens() Owner {
        tokensFrozen = false;
    }

    function freezeTokens() Owner {
        tokensFrozen = true;
    }

    // add a check so only cofounder and founder can do this
    function setProdContractAddr(address _contractaddr) Owner onlyWhenFrozen returns (bool success) {
        realTokenAddr = _contractaddr;
        return true;
    }

//////////////////////////////
//ERC20 start Token Functions/
/////////////////////////////

    function transfer(address _to, uint256 _amount) public returns (bool success) {
        if(msg.sender != owner && tokensFrozen)  
            return false;
        if(_amount <= 0)
            return false;
        if(balances[msg.sender] < _amount)
            return false;
        if(balances[_to] + _amount < balances[_to]) // overflow check
            return false;
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        Transfer(msg.sender, _to, _amount);
        return true;
    }


   
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
        if(tokensFrozen && msg.sender != owner)
            return false;
        if(balances[_from] < _amount)
            return false;
        if(balances[_from] - _amount < 0)
            return false;
        if(balances[_to] + _amount < balances[_to])
            return false;
        if(balances[_to] + _amount <= 0)
            return false;
        if(_amount > allowed[_from][msg.sender])
            return false;
        balances[_from] = balances[_from].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_amount);
        Transfer(_from, _to, _amount); // Notifies blockchain
        return true;
    }


    function approve(address _spender, uint256 _amount) public returns (bool success) {
        allowed[msg.sender][_spender] = _amount;
        Approval(msg.sender, _spender, _amount); // Notifies blockchain
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 _amount) {
        return allowed[_owner][_spender];
    }

    function balanceOf(address _person) constant returns (uint256 _amount) {
        return balances[_person];
    }

    function totalSupply() constant returns (uint256 totalSupply) {
        return _totalSupply;
    }

//////////////////////////////
//ERC20 End  Token  Functions/
/////////////////////////////

    // fallback function
    function() payable {
        revert();
    }
}