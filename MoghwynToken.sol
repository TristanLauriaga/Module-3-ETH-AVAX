// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MoghwynToken is ERC20("Moghwyn", "MGH") {
    address public owner;

    event TokensMinted(address indexed receiver, uint256 amount);
    event TokensTransferred(address indexed sender, address indexed receiver, uint256 amount);
    event TokensBurned(address indexed burner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function mint(address _receiver, uint256 _amount) public onlyOwner {
        _mint(_receiver, _amount);
        emit TokensMinted(_receiver, _amount);
    }

    function transfer(address _receiver, uint256 _amount) public override returns (bool) {
        require(_receiver != address(0), "Invalid receiver address");
        require(_amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");

        _transfer(msg.sender, _receiver, _amount);
        emit TokensTransferred(msg.sender, _receiver, _amount);
        return true;
    }

    function burn(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than zero");
        require(balanceOf(msg.sender) >= _amount, "Insufficient balance");

        _burn(msg.sender, _amount);
        emit TokensBurned(msg.sender, _amount);
    }
}
