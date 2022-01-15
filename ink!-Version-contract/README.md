## Install Rust and the Rust toolchain

#####  1.Install `rustup` by running the following command: 

` curl https://sh.rustup.rs -sSf | sh `

##### 2.Configure your current shell to reload your PATH environment variable so that it includes the Cargo `bin` directory by running the following command: 

` source ~/.cargo/env `

##### 3.Configure the Rust toolchain to default to the latest `stable` version by running the following commands: 

`rustup default stable`

`rustup update`

##### 4. Add the `nightly` release and the `nightly` WebAssembly (`wasm`) targets by running the following commands: 

`rustup update nightly`

`rustup target add wasm32-unknown-unknown --toolchain nightly`

##### 5. Verify your installation by running the following commands: 

`rustc --version`
`rustup show`

## Setup RainbowDao Protocol Node

### 1. Installing The Substrate Contracts Node

 We need to use a Substrate node with the built-in `pallet-contracts` pallet. For this workshop we'll use a pre-configured Substrate node client. 

`cargo install contracts-node --git https://github.com/paritytech/substrate-contracts-node.git --tag v0.3.0 --force --locked`

### 2. ink! CLI

```
# For Ubuntu or Debian users
sudo apt install 
# For MacOS users
brew install binaryen
```

#### cargo-contract

`cargo install cargo-contract --vers 0.15.0 --force --locked`

### 3. Running a Substrate Smart Contracts Node

` substrate-contracts-node --dev --tmp `



## Setup Contracts

RainbowDao Protocol Contracts are provided in `https://github.com/RainbowcityFoundation/RainbowDAO-Protocol-Ink-milestone_1.git`. 

It's developed with ink!.

### Get contracts

```
git clone git@github.com:RainbowcityFoundation/RainbowDAO-Protocol-Ink-milestone_1.git
```



## Compile contracts from source code

The RainbowDAO-Protocolprovides script to simplify the contract compilation process while collecting the editing results into a unified directory to facilitate contract deployment and usage. Execute in the project root directory

```bash
bash ./build.sh
```

All contract compilation results are saved in the release directory.

### Compile  one by one 

##### compile

` cargo +nightly contract build`

In RainbowDAO-Protocol-Ink-milestone_1 project 

like cd erc20/       

erc20 > erc20_factory 

multisig>multisig_factory

role_manage > route_manage >users_manage > kernel > income_category

## Deploy

The RainbowDao Protocol creates the substrate chain to connect the POLKADOT Ecology, and all contracts are deployed on the RainbowDao Protocol chain. This section explains how to make use of Polkadot JS App to deploy contracts.

Use `https://polkadot.js.org/apps/` upload target/ink .contract file to deploy contract.

#### 1.set the node IP and port ( `ws://127.0.0.1:9944` default).

![](./docs_img/1.png)

#### Upload contracts

Enter `Developer-> Contracts` and click Upload WASM.

![](./docs_img/2.jpg)

Select the ABI and WASM files that required to deploy contract, click `Upload`, and `Submit and Sign`.

![](./docs_img/3.jpg)

Wait a moment and the contract code will be uploaded.

### Deploy contracts

After you upload the contracts, you can instantiate the contract on the chain. In substrate, you need to perform the contract’s initialization function, usually new or the default function.

![](./docs_img/4.jpg)

Select the initialization function call, fill in the initialization parameters, set the main contract administrator, and set the contract initial balance, click `Deploy` before set a proper endornment number, normally 500 is enough. Note that the deployment salt is used.

## Initialization

![](./docs_img/5.jpg)

Deploy govnance_dao you should choose a token as covernance token.

![](./docs_img/6.jpg)

# Setup RainbowDao Protocol Front-end

## Install `Polkadot JS Extension`

Please install `Polkadot JS Extension` before you start. You can get it from here https://polkadot.js.org/extension/

### Get source code

Please get the code from `https://github.com/RainbowcityFoundation/RainbowDAO-Protocol-Ink-UI-milestone_1.git`

```
git clone https://github.com/RainbowcityFoundation/RainbowDAO-Protocol-Ink-UI-milestone_1.git
```



## Front-end 

##### entrance:

```	
https://www.rainbowdao.io/polkadot
```



## Install `Polkadot JS Extension`

Please install `Polkadot JS Extension` before you start. You can get it from here https://polkadot.js.org/extension/

### Get gas from ALICE

In `https://polkadot.js.org/apps` Account page, use account  send gas to your extension account.

### Then

You can use `https://www.rainbowdao.io/polkadot` to create token/multisign wallet.  Test  Protocol Management.



