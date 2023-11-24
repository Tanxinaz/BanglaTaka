# ElevateX


ElevateX is a simple ERC-20 token smart contract built on the Ethereum blockchain. The contract allows users to transfer tokens, as well as buy and sell tokens for a specified price.


### Prerequisites:

In order to use the BanglaTaka contract, you will need the following:

An Ethereum wallet such as MetaMask,
some Ethereum cryptocurrency to use for transactions and
knowledge of Solidity and smart contract development

### Installation
To use the ElevateX contract, simply deploy the ElevateX.sol contract to your Ethereum network of choice using your preferred method, such as Remix or Truffle. You will also need to deploy the storage.sol contract and two scripts ChainlinkGoldPriceFeed.sol and storage.js to interact with the Chainlink Price Feed contract (scripts are not completed yet due to regulatory and use case changes).

### Usage:

Once the ElevateX contract is deployed, you can interact with it using any Ethereum wallet that supports ERC-20 tokens. You can transfer tokens to other users, as well as buy and sell tokens using the buy() and sell() functions respectively.

You will also need to periodically update the price of the token using the updatePrice() function. This function fetches the latest price from the Chainlink Price Feed contract and updates the price in the ElevateX contract accordingly.


### License
This project is licensed under the MIT License.


