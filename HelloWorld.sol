pragma solidity 0.5.2;

contract HelloWorld{
    string public text;

    function setText(string memory myText) public {
        text = myText;
    }

}
