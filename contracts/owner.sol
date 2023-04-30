// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Cannot transfer ownership to zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
