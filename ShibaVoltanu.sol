pragma solidity 0.5.17;

library SafeMath{
    //PURE?
    //não usa nada que o usuário está passando, ou transação. não consulta, e nem altera blockchain
    //as funções PURAS são grátis.
    function add(uint a, uint b) internal pure returns(uint) {
        uint c = a+b;
        require (c >= a, "Sum Overflow.");
        return c;
    }

    function sub(uint a, uint b) internal pure returns(uint) {
        require(b<=a, "Sub Overflow.");
        uint c = a - b;
        return c;
    }

    function mul(uint a, uint b) internal pure returns(uint) {
        if(a==0 || b==0){
            return 0;
        }
        uint c = a * b;
        require(c / a == b,"Mul Overflow");
        return c;
    }

    function div(uint a, uint b) internal pure returns(uint) {
        require(b>0, "Div Overflow");
        uint c = a / b;
        return c;
    }
}

contract Ownable {
    address payable public owner;

    event OwnershipTransferred(address newOwner);

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function transferOwnership(address payable newOwner) onlyOwner public {
        owner = newOwner;
        emit OwnershipTransferred(newOwner);
    }

}

contract ShibaVoltanu is Ownable{
    using SafeMath for uint;

    string public constant name = "Shiba Voltanu";
    string public constant symbol = "SVU";
    uint8 public constant decimals = 18;
    uint public totalSupply;

    mapping(address=>uint) balances;

    event Mint(address indexed to, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);


    function mint(address to, uint tokens) onlyOwner public{
        balances[to] = balances[to].add(tokens);
        totalSupply = totalSupply.add(tokens);

        emit Mint(to, tokens);
    }

    function transfer(address to, uint tokens) public {
        require(balances[msg.sender] >= tokens);
        require(to != address(0));

        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);

        emit Transfer(msg.sender, to, tokens);
    }
}
