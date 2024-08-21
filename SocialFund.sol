//Recebe doações e permite que o proprietário do contrato distribua os fundos para uma causa social.


pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SocialFund {
    address public owner;
    uint256 public socialFundBalance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Apenas o proprietário pode executar esta função");
        _;
    }

    function donateToSocialFund() public payable {
        require(msg.value > 0, "Doação deve ser maior que zero");
        socialFundBalance += msg.value;
    }

    function distributeToCharity(address payable charityAddress) public onlyOwner {
        require(socialFundBalance > 0, "Fundo social vazio");
        charityAddress.transfer(socialFundBalance);
        socialFundBalance = 0;
    }
}
