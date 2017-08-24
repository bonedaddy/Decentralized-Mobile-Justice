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

contract Owned {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    function Owned() {
        owner = msg.sender;
    }

    // change this so we can have an array of owners
    function transferOwnership(address _newOwner) onlyOwner returns (bool success) {
        owner = _newOwner;
    }
}

contract DMJ {

    string public name = "Decentralized Mobile Justice";
    string public symbol = "DMJ";
    uint8 public decimals = 18;
    uint256 public _totalSupply = 100000000 * 1 wei;
    bool public transfersFrozen;

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event Freeze(bool indexed Froozen);
    event Thaw(bool indexed Thawed);

    mapping (address => uint256) public balances;
    
    function DMJ() {
        balances[msg.sender] = _totalSupply;
    }

    function freezeTransfers() returns (bool Frozen) {
        transfersFrozen = true;
        Freeze(true);
        return true;
    }

    function thawTransfers() returns (bool Thawed) {
        transfersFrozen = false;
        Thaw(true);
        return true;
    }


}