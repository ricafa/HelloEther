pragma solidity 0.5.17;

library SafeMath{
    //PURE?
    //não usa nada que o usuário está passando, ou transação. não consulta, e nem altera blockchain
    //as funções PURAS são grátis.
    function sum(uint a, uint b) internal pure returns(uint) {
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

contract HelloWorld{
    using SafeMath for uint;

    address public owner;

    string public text;
    uint public number;
    address public userAddress;
    bool public answer;
    mapping(address=>uint) public hasInteracted;
    mapping(address=>uint) public balances;

    constructor() public {
        ownder = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function setText(string memory myText) onlyOwner public {
        text = myText;
        setInteracted();
    }

    function setNumber(uint myNumber) public payable{
        require(msg.value >= 1 ether, "Insuffiencient ETH sent;");
        balances[msg.sender = balances[msg.sender].sum(msg.value)];
        number = myNumber;
        setInteracted();
    }

    //sem parâmetros, pois o contrato já tem essa informação. o retorno é a minha carteira.
    function setUserAddres() public {
        userAddress = msg.sender;
        setInteracted();
    }

    //qualquer coisa é true. vazio é false.
    function setAnswer(bool trueOrFalse) public {
        answer = trueOrFalse;
        setInteracted();
    }

    //contar quantas vezes alguém interagiu com contrato.
    //não pode ser chamada pelo usuário.
    function setInteracted() private {
        hasInteracted[msg.sender] = hasInteracted[msg.sender].sum(1);
    }
    
    //transferir ether de uma conta para outra é uma funcionalidade nativa
    //esta função é intermediária de uma função que já existe.
    //função Transfer.
    function sendETH(address payable targetAddress) public payable {
        targetAddress.transfer(msg.value);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");
        
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
    }   
    
    //VIEW
    //funções view, só alteram, não consultar nada no blockchain
    function sumStored(uint a) public view returns(uint) {
        return a.sum(number);
    }

}
