# Multi Signature Smart Contract

The Multi Signature Smart Contract project is a decentralized solution for implementing multi-signature wallets on the Ethereum blockchain. It utilizes Solidity for smart contract development, Hardhat for development environment, testing, and deployment, and leverages an ERC20 Contract interface provided by @openzeppelin.

## Overview

The Multi Signature Smart Contract allows multiple parties to jointly control funds in a wallet by requiring a predefined number of signatures to execute a transaction. This enhances security by reducing the risk of unauthorized access to funds.

## Features

- **Multi-Signature Functionality**: The smart contract supports multi-signature functionality, requiring a configurable number of signatures from authorized parties to approve transactions.
- **ERC20 Compatibility**: Utilizes an ERC20 Contract interface from @openzeppelin, allowing interaction with ERC20 tokens within the multi-signature wallet.

## Technologies Used

- **Solidity**: A high-level language for implementing smart contracts on the Ethereum blockchain.
- **Hardhat**: A development environment, testing framework, and deployment pipeline for Ethereum smart contracts.
- **ERC20 Contract Interface**: An interface provided by @openzeppelin for interacting with ERC20 tokens.

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/multi-signature-smart-contract.git
   cd multi-signature-smart-contract
   ```
2. Install dependencies: `npm install`
3. Configure your environment variables and parameters in the .env file.
4. Compile the contracts: `npx hardhat compile`
5. Run tests to ensure contract functionality: `npx hardhat test`
6. Deploy the smart contracts to the desired Ethereum network: `npx hardhat deploy --network <network-name>`

## Usage

To use the Multi Signature Smart Contract:

1. Deploy the contract to the Ethereum network of your choice.
2. Configure the required number of signatures and authorized parties using the contract's functions.
3. Interact with the contract to perform multi-signature transactions, such as transferring funds or approving transactions.

## Contributing

Contributions to the Multi Signature Smart Contract project are welcome! If you have suggestions, feature requests, or find any issues, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
