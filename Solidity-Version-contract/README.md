# Documentation on how to run the project

# Getting Started

## Dependencies

- Linux or Mac
- node ≥ 16


## Installing

```bash
git clone https://github.com/RainbowDAO/METATHON-RainbowDAO-Factory.git
npm install
```

**Note**: Only the Metamask wallet is available for this demo


## Deploy Contracts
```bash 
truffle compile && truffle migrate
```

You will deploy contracts
- ERC20Factory
- DaoFactory
- DaoManage
- Authority
- Vault


When the deployment is finished, the address of the deployed contracts will be displayed on the console as follows.
```
DaoFactory:  0x...
```

