// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./storage.sol";
import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ElevateX {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    uint256 public price;
    AggregatorV3Interface internal priceFeed;
    Storage storageContract;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply, address _priceFeed) {
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply,
        address _priceFeed,
        address _storageAddress
    } {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
        priceFeed = AggregatorV3Interface(_priceFeed);
        storageContract = Storage(_storageAddress);
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function updatePrice() public {
        (, int256 priceRaw,,,) = priceFeed.latestRoundData();
        uint256 newPrice = uint256(priceRaw);
        price = (newPrice * 10**uint256(decimals)) / 1000;
    }

    function buy(uint256 _amount) public {
        require(_amount > 0);
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        price = (totalSupply * price) / (totalSupply - _amount);
    }

    function sell(uint256 _amount) public {
        require(_amount > 0);
        uint256 banglaTakaAmount = (_amount * price) / 10**uint256(decimals);
        balanceOf[msg.sender] += banglaTakaAmount;
        totalSupply += banglaTakaAmount;
        price = (totalSupply * price) / (totalSupply + banglaTakaAmount);
    }
}
