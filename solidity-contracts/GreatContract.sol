pragma solidity ^0.4.4;

contract GreatContract {
    address private contractOwner;
    uint256 private tokenPrice;
    uint256 private numberOfAllTokens;
    uint256 private numberOfAvailableTokens;
    uint256 private numberOfSoldTokens;
    mapping(address => uint256) private purchasers;

    function GreatContract() public {
        contractOwner = msg.sender;
        tokenPrice = 0.79 ether;
        numberOfAllTokens = 12;
        numberOfAvailableTokens = numberOfAllTokens;
        numberOfSoldTokens = 0;
    }

    function() external payable {
        uint256 amount = msg.value / tokenPrice;
        require(msg.value % tokenPrice == 0 && amount <= numberOfAvailableTokens);
        purchasers[msg.sender] += amount;
        numberOfSoldTokens += amount;
        numberOfAvailableTokens -= amount;
    }

    modifier OnlyContractOwner {
        require(msg.sender == contractOwner);
        _;
    }

    function getContractOwner() external constant returns (address) {
        return (contractOwner);
    }

    function getNumberOfTokens(address _address) external constant returns (uint256) {
        return purchasers[_address];
    }

    function getTokenPrice() external constant returns (uint256) {
        return (tokenPrice);
    }

    function setTokenPrice(uint256 value) external OnlyContractOwner {
        tokenPrice = value;
    }

    function getNumberOfAllTokens() external OnlyContractOwner constant returns (uint256) {
        return numberOfAllTokens;
    }

    function setNumberOfAllTokens(uint256 value) external OnlyContractOwner {
        require(value >= numberOfSoldTokens);
        numberOfAllTokens = value;
        numberOfAvailableTokens = numberOfAllTokens - numberOfSoldTokens;
    }

    function getNumberOfAvailableTokens() external OnlyContractOwner constant returns (uint256) {
        return numberOfAvailableTokens;
    }

    function getNumberOfSoldTokens() external OnlyContractOwner constant returns (uint256) {
        return numberOfSoldTokens;
    }
}