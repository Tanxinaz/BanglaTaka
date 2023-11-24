// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ElevateXStorage {
    mapping(address => uint256) public balanceOf;
    uint256 public totalSupply;

    function setBalance(address account, uint256 amount) external {
        balanceOf[account] = amount;
    }

    function setTotalSupply(uint256 amount) external {
        totalSupply = amount;
    }
}
