# 1. Aura SDK APIs
The Aura SDK has supported 2 type of Wallet
1. the DigitalWallet is In-App Wallet, support you all of method for work with chain ( e.x : Create Wallet, Restore Wallet, Check Balance, Send Transaction, Check Transaction History...)
2. The ExternalWallet use 3rd Wallet Application for work with chain (ex : C98 Wallet, Kepler Wallet ... )

``` Dart

abstract class AuraSDK {
  DigitalWallet get digitalWallet;
  ExternalWallet get externalWallet;
}

```

### Digital Wallet 

The Digital Wallet supported methods are as follows:

- `createRandomHDWallet()`: generates a random HD wallet.
- `restoreHDWallet({required String mnemonic})`: restores a wallet using a given mnemonic phrase.
- `checkMnemonic({required String mnemonic})`: checks the validity of a mnemonic phrase.
- `checkWalletBalance({required String address})`: retrieves the balance of a given wallet address.
- `checkWalletHistory({required String address})`: retrieves the transaction history of a given wallet address.
- `createTransaction({required String fromAddress, required String toAddress, required String amount})`: creates a transaction with a given sender address, recipient address, and amount.
- `signTransaction({required Wallet wallet, required List<MsgSend> msgSend, required Fee fee, })`: signs a transaction with a given wallet, message, and fee.
- `submitTransaction({required Tx signedTransaction})`: submits a signed transaction to the blockchain.

### External Wallet

The External Wallet supported methods are as follows:

- `connectWallet()`: connects to a third-party wallet application.
- `requestAccountInfo()`: retrieves the account information from the connected wallet application.
- `sendTransaction(String fromAddress, String toAddress)`: sends a transaction using the connected wallet application.
- `signContract(String contractAddress)`: signs a contract with a given contract address using the connected wallet application.



# 2. Digital Wallet
### Create Random Wallet
- 
