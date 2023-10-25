# Aura SDK - Unity

Aura SDK is a package that eases the process of connecting and communicating with Aura Network. The package supports using external wallet such as Coin98 Wallet and using in-app wallet.

## Compatibility notes

This SDK has been tested working with Unity 2020.3.30f1, Unity 2021.3.22f1, and Unity 2022.1.23f1. The settings are as below

| Unity Version | Scripting Backend | API Compatibility Level | Notes |
| ------------- | ----------------- | ----------------------- | ----- |
| 2022.1.23f1   | IL2CPP            | Net Standard 2.1        |       |
| 2021.3.22f1   | IL2CPP            | Net Standard 2.1        |       |
| 2020.3.30f1   | IL2CPP            | Net Standard 2.0        | There are some incompatibility issues with Net Standard 2.0, addressed [here](#net-standard-20-incompatibility-issue) |

## Installation

### Installation Method 1: Download the project template

This method is the easiest way to install Aura SDK. We have all configured Nuget dependencies, customized Android manifests, and made samples for you. The steps are as below:

- Step 1: Clone this repository. If the editor prompts you of importing issues, just "Ignore" it.
- Step 2: Wait for a while. Everything should be all set for you. If they aren't, follow the additional steps below.
- Step 3: Select ```NuGet -> Restore Packages``` to resolve NuGet dependencies.

### Installation Method 2: Download the unitypackage file

This method suits installing Aura SDK to an existing project. It involves downloading and importing the ```.unitypackage``` file, adding package manager and Nuget dependencies.

- Step 1: Download and import aura-sdk-unity.unitypackage file in the Releases folder.
- Step 2: Install NuGetForUnity package using the github URL <https://github.com/GlitchEnzo/NuGetForUnity.git?path=/src/NuGetForUnity>.
- Step 3: Install AdvancedPlayerPrefs using the github URL <https://github.com/realphamanhtuan/unity-advanced-playerprefs.git>. This library is used for wallet information encryption.
- Step 4: (Unity <=2021 only) Disable ```Assembly Version Validation``` in the ```Player Settings```. For Unity 2022 or later, this option is disabled by default.
- Step 5: Append these NuGet dependencies into your Assets/packages.config file. If there is no packages.config file in the Assets folder, you can create one and use the content below.

```xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
    <!-- Only append the part below if the file already exists -->
    <package id="BouncyCastle.Cryptography" version="2.2.1" />
    <package id="Microsoft.Extensions.Logging.Abstractions" version="1.0.0" />
    <package id="NBitcoin" version="7.0.30" />
    <package id="Newtonsoft.Json" version="13.0.1" />
    <package id="protobuf-net" version="2.3.17" />
    <package id="System.Buffers" version="4.5.0" />
    <package id="System.Private.ServiceModel" version="4.5.3" />
    <package id="System.Reflection.DispatchProxy" version="4.5.0" />
    <package id="System.Reflection.Emit" version="4.3.0" />
    <package id="System.Reflection.Emit.ILGeneration" version="4.3.0" />
    <package id="System.Reflection.Emit.Lightweight" version="4.3.0" />
    <package id="System.Reflection.TypeExtensions" version="4.4.0" />
    <package id="System.Security.Principal.Windows" version="4.5.0" />
    <package id="System.ServiceModel.Primitives" version="4.5.3" />
    <!-- Only append the part above if the file already exists -->
</packages>
```

- Step 6: Select ```NuGet -> Restore Packages``` to resolve NuGet dependencies. Despite being one of the best NuGet package managers for Unity, NuGetForUnity sometimes poses issues in restoring packages. If ```Restore Packages``` doesn't work for you, try ***restarting your Unity Editor***.

- Step 7 (for WebGL builds): When building a package, Unity automatically strips unused managed code for faster loading and running time. For more information on this matter, learn more [here](https://docs.unity3d.com/Manual/ManagedCodeStripping.html). In our SDK, proto-generated files get stripped out when building for WebGL platform. To prevent that from happening, you should either set the ```Managed Stripping Level``` to ```Minimal``` or append (or create if not exists) the ```link.xml``` file in the Assets folder with the content below:


```xml
<!--Assets/link.xml content-->
<linker>
    <assembly fullname="protobuf-net"  preserve="all"/>
</linker>
```

## Usage

### Initialize an InApp Wallet

To initialize an InApp wallet, you need a mnemonic phrase and a passphrase (default to an empty string). The mnemonic should look like below.

```plain
garage audit public frown ball tribe dragon outdoor rug point radio funny clean furnace range have hire second use taxi regular mutual other disease
```

Note that this mnemonic phrase is randomly generated for demonstrative purposes only. You should not use this phrase in any real-life operations, because you might lose your money.
For more information on mnemonic code, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki>.

The code below demonstrates the initialization of InApp wallet.

#### Create a random HD Wallet

```csharp
InAppWallet wallet = InAppWallet.CreateRandomHDWallet(passphrase = "");

// get mnemonic of the just-generated wallet
Debug.Log(wallet.mnemonic);
```

Note that if the passphrase isn't specified, an empty string ```""``` will be used.
For more information on how passphrase is used in generating seed and keys, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#user-content-From_mnemonic_to_seed>.

#### Restore HD Wallet using existing mnemonic

```csharp
InAppWallet wallet = InAppWallet.RestoreHDWallet(mnemonic.text);

// get address of the just-imported wallet. Wallet address is a base32 address (alphanumeric excluding '1' (seperator), 'b', 'i' (so not to be confused with 'l'), 'o' (so not to be confused with '0')), prefixed by the human-readable part "aura1", and suffixed by the six-character-long checksum. The address should look like this: aura1jr8x0qy2m9ccp0jslyglnljrgxumvrg4rsvcn4
Debug.Log(wallet.address);
```

Note that if the passphrase isn't specified, an empty string ```""``` will be used.
For more information on how passphrase is used in generating seed and keys, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#user-content-From_mnemonic_to_seed>.

### Check wallet balance

```csharp
var balanceCheckResult = await wallet.CheckBalance(denom);

if (balanceCheckResult.success) {
    BigInteger balance = balanceCheckResult.balance;
} else {
    Debug.Log("Failed checking balance");
}
```

The balance returned is in specified Denom. You can also use the default Aura denom (used for transaction fee paying) by referencing `Constant.AURA_DENOM`.

### Make a transaction

A transaction is a message that you send to the network in order to perform a specific action. We implement two types of transaction, which are: money sending and contract executing. The code below demonstrates the steps to *create*, *sign*, and *broadcast* a transaction.

```csharp
/// Create a money sending transaction
var tx = await wallet.CreateSendTransaction(toAddress.text, amount.text);

/// SignTransaction will perform the signings and embed the result into the existing tx variable.
await wallet.SignTransaction(tx);

/// BroadcastTx sends the transaction data to the lcd node of Aura Network and returns the http response, from which you can parse the transaction details.
var broadcastResponse = await AuraSDK.InAppWallet.BroadcastTx(tx);

if (broadcastResponse.StatusCode == 200){
    JObject resObj = JObject.Parse(broadcastResponse.Content);
    string txhash = resObj["tx_response"]["txhash"].ToString();
}
```

The Aura LCD **DOESN'T WAIT** for the transaction to be included in a block before returning a response. Therefore, after getting `txhash`, you have to periodically check for its completeness, using [this guide](#query-transaction-details).

For blocking transaction send, use the function `BroadcastTxBlock`. This function is not recommended, so use it at your own risks.

### Interact with smart contract

Firstly, let's query the state of a contract. The code below demonstrates how to do that.

```csharp
var response = await InAppWallet.QuerySmartContract(
    contractAddress: "aura158kn7jhsvttsmhn4q9jf2mteu5nsq8e6lxrfgmnhzg55ghftfh6qngxk6g",
    queryJson: "{\"get_wheel_rewards\":{}}");
Debug.Log(response.StatusCode + " " + response.Content);
```

The code below illustrates how you can send **Execute** message to a contract. Note that for MsgExecute, you need to sign your transaction before broadcasting it.

```csharp
/// Create a contract executing transaction
Tx tx = await wallet.CreateExecuteContractTransaction(
    //contract address
    "aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx",
    //message
    "{\"transfer_nft\": {\"recipient\": \"aura1jr8x0qy2m9ccp0jslyglnljrgxumvrg4rsvcn4\",\"token_id\": \"2\"}}"
);

/// SignTransaction will perform the signings and embed the result into the existing tx variable.
await wallet.SignTransaction(tx);

/// BroadcastTx sends the transaction data to the lcd node of Aura Network and returns the http response, from which you can parse the transaction details.
await AuraSDK.InAppWallet.BroadcastTx(tx);
```

### Estimate transaction gas 

Before sending the transaction, you can also simulate its running to check its estimated gas fee. The gas fee can be shown to end-users to pre-alert the fee required. The code below demonstrates this action.

```csharp
var tx = await DemoIAW.wallet.CreateSendTransaction(toAddress.text, AuraSDK.Constant.AURA_DENOM, amount.text);
await DemoIAW.wallet.SignTransaction(tx);

var simulateResponse = await AuraSDK.InAppWallet.SimulateTx(tx);
JObject resObj = JObject.Parse(simulateResponse.Content);
Debug.Log(resObj["gas_info"]["gas_used"].ToString());
```

### Query transaction details

The code below demonstrates how you query a transaction's details. This function is useful in querying past transactions and checking ongoing transactions for their completeness.

```csharp
// Query transaction details using txhash
var txCheckResponse = await AuraSDK.InAppWallet.QueryTransactionDetails(txhash);

if (txCheckResponse.StatusCode == 200){
    JObject txDetails = JObject.Parse(txCheckResponse.Content);

    ulong height;
    if (ulong.TryParse(txDetails["tx_response"]["height"].ToString(), out height) && height > 0){
        // The transaction is now included in some block
        ulong code;
        if (ulong.TryParse(txDetails["tx_response"]["code"].ToString(), out code) && code > 0){
            Logging.Error("Transaction failed. Code =", code);
            break;
        } else {
            Logging.Info("Transaction successful. Height =", height);
            break;
        }
    } else {
        Debug.Log("Transaction is being processed. Try again later");
    }
} 
```

### View transaction history (deprecated)

The code below shows how you can query transaction history and print it out to the log.

```csharp
List<AuraTransaction> transactionHistory = await wallet.CheckWalletHistory();
foreach(AuraTransaction transaction in transactionHistory){
    Debug.Log($"{transaction.type}: {transaction.fromAddress} -> {transaction.toAddress} {transaction.amount} uaura\n");
}
```

### Save your wallets

Aura SDK comes with a utility called InAppWalletManager, which is designed to simplify the process of securely save wallet information to the storage. InAppWalletManager can save multiple InAppWallet instances and manage them all at once.

To use the InAppWalletManager, you first need your user to create a **password**. Then, you can initialize the InAppWalletManager as below.
Note that this `password` differs from the `passphrase` used when creating an InAppWallet.

```csharp
// InAppWalletManager can only be successfully initialized once. To change the password, call the ChangePassword function.
bool passwordIsCorrect = InAppWalletManager.Initialize(password);

if (passwordIsCorrect){
    // Do something
}
```

The code below demonstrates how to save and get the wallet out of the secure storage.

```csharp
InAppWalletManager.AddWallet(InAppWallet.CreateRandomHDWallet());
// The wallet then will be saved to PlayerPrefs and can be retrieved later.
```

```csharp
string[] addresses = InAppWalletManager.GetWalletAddresses();

foreach(string address in addresses){
    InAppWallet wallet = InAppWalletManager.GetWalletByAddress(address);
    //Do something with your wallet.
}
```

### Test your code

To verify if the SDK runs correctly or the transactions are performed according to your wish, use AuraScan tool located at <https://aurascan.io> or <https://serenity.aurascan.io> as for the testnet.

### Configuration

Network configurations are defined in the configuration file ```inapp_wallet/config/Constant.cs```. We have previously defined three network profiles, including Serenity Testnet, Euphoria Staging Network, and Aura Mainnet. Change the #define directive to one of the followings to switch to corresponding profile: USE_NETWORK_EUPHORIA, USE_NETWORK_SERENITY, USE_NETWORK_MAINNET. By default, Euphoria is used.

## Footnotes

### Net Standard 2.0 incompatibility issue

We have tested the SDK with net standard 2.0 compatibility level, and found some issues, described here.

#### System.Reflection.Emit duplications

We use a library called `protobuf-net`, whose net standard2.0 version depends on `System.Reflection.Emit`, `System.Reflection.Emit.ILGeneration`, and `System.Reflection.Emit.Lightweight` libraries. Those libraries have, unfortunately already included in Unity Building System. 

Consequently, when you restore packages using `Nuget -> Restore Packages`, warnings on duplications will arise. This problem was caused by the fact that `Nuget` and `Unity` use different dependency configuration file. 

The solution for this would be ***MANUALLY DELETE*** the duplications in `Asset/Packages` folder. The list below should show you the folders which you can delete.

- `Assets/Packages/System.Reflection.Emit.x.x.x`
- `Assets/Packages/System.Reflection.Emit.ILGeneration.x.x.x`
- `Assets/Packages/System.Reflection.Emit.Lightweightx.x.x`

#### System.ServiceModel.Primitives can't be loaded

`protobuf-net` also depends on `System.ServiceModel.Primitives`, whose dependecies isn't compatible with `Net Standard 2.0`. You will see the warnings and build failure because the library could not be loaded.

We don't use `System.ServiceModel.Primitives` library, so it is ***SAFE TO MANUALLY DELETE*** the folder. The path below should point you to the library.

- `Assets/Packages/System.ServiceModel.Primitives.x.x.x`
