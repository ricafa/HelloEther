pragma solidity 0.5.3;

contract HelloWorld{
    string public text;
    uint public number;
    address public userAddress;
    bool public answer;
    mapping(address=>uint) public hasInteracted;

    constructor(string memory initialMessage) public {
        text = initialMessage;
        setInteracted();
    }

    function setText(string memory myText) public {
        text = myText;
        setInteracted();
    }

    function setNumber(uint myNumber) public payable{
        require(msg.value >= 1 ether, "Insuffiencient ETH sent;");
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
        hasInteracted[msg.sender] += 1;
    }
    
    //transferir ether de uma conta para outra é uma funcionalidade nativa
    //esta função é intermediária de uma função que já existe.
    //função Transfer.
    function sendETH(address payable targetAddress) public payable {
        targetAddress.transfer(msg.value);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, 'Insuficient funds');
        
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    //PURE?
    //não usa nada que o usuário está passando, ou transação. não consulta, e nem altera blockchain
    //as funções PURAS são grátis.
    function sum(uint num1, uint num2) public pure returns(uint) {
        return num1 + num2;
    }
    
    //VIEW
    //funções view, só alteram, não consultar nada no blockchain
    function sumExists(uint num1) public view returns(uint) {
        return num1 + number;
    }

}
