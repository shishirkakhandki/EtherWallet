// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract EtherWallet {
    // An example of a basic wallet.
    // Anyone can send ETH.
    // Only the owner can withdraw.

    uint public balance;
    address payable immutable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "Withdraw failed: Error - Not the owner");
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdraw failed");
    }

    receive() external payable {
        balance += msg.value;
    }
}
