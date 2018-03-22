pragma solidity ^0.4.16;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}
contract ERC20Basic {
  function balanceOf(address who) public constant returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

contract TokenA {
    uint256 public balances = 0;
    uint256 public id;
    address public wallet;
    
    function TokenA(uint256 _id, address _wallet) public {
        id = _id;
        wallet = _wallet;
    }
    
    function() public payable {
        require(wallet.call.value(msg.value)());
        balances = msg.value;
    }

    function moveThirdToken(address contractAddr) public returns (bool) {
        ERC20Basic erc20 = ERC20Basic(contractAddr);
        return erc20.transfer(wallet,erc20.balanceOf(this));
    }
}

contract TokenB {
    mapping(uint256 => address) tokens;
    address wallet;
    
    function TokenB(address _wallet) public {
        wallet = _wallet;
    }
    
    function createToken(uint256 id) public returns(TokenA addr) {
        TokenA token = new TokenA(id, wallet);
        tokens[id] = token;
        return token;
    }
    
    function() public {
        revert();
    }
}

contract TokenC is ERC20Basic {
    mapping(address => uint256) balances;
    
    function TokenC() public {
        
    }

    function balanceOf(address who) public constant returns (uint256) {
        return balances[who];
    }
    
    function mint() public {
        balances[msg.sender] = balances[msg.sender] + 10000 * (10 ** 18);
    }
    
    function transfer(address to, uint256 value) public returns (bool) {
        balances[msg.sender] = balances[msg.sender] - v;
        balances[to] = balances[to] + v;
        return true;
    }
}