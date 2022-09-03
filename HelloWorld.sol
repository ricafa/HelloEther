pragma solidity 0.5.2;

contract HelloWorld{
    string public text;
    uint public number;
    address public userAddress;
    bool public answer;
    mapping(address=>bool) public hasInteracted;

    constructor(string memory initialMessage) public {
        text = initialMessage;
        setInteracted();
    }

    function setText(string memory myText) public {
        text = myText;
        setInteracted();
    }

    function setNumber(uint myNumber) public {
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

    //se usuário há enviou alguma transação fica true.
    //não pode ser chamada pelo usuário.
    function setInteracted() private {
        hasInteracted[msg.sender] = true;
    }

}
