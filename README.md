# ETH + AVAX Intermediate Module 3

This is my take on our Assessment on Module 3. We are tasked to make a smart contract that the owner can mint burn and transfer tokens.
.
## Description

This program is written in solidity, a programming language used in web3 blockchain. And I used REMIX IDE for my online IDE compiler. A brief description on the purpose and use of my assessment. This is my custom token using ERC20 it is named after my favorite boss character in elden ring, Mohgwyn. It can mint burn and transfer this custom tokens on one account to another account.

You can run the code in the website https://remix.ethereum.org/ it is a good free and online IDE for solidity and etherium. When you get there just add the file and then there you go you can run my code and test it out for yourself.

========================================

## Setting up

Before you can run and make your own token, you need the ERC20 custom contract it is located at this link https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol we need to import this first before doing anything.

note that I used the version of solidity 0.8.20 this is the latest version I think.
below is the source code of my systemn.

```
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
```

This is the whole functionality of my code and the generalization of how it will run.

## Running the Code

Running the code is quite simple actually just go the deploy & run transactions and just click the orange button that says "DEPLOY".

## Author

Lauriaga, Lancetristan B. @tristanaenaeee on Instagram

