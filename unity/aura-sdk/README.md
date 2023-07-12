# Aura SDK - Unity

Aura SDK is a package that eases the process of connecting and communicating with Aura Network. The package supports using external wallet such as Coin98 Wallet and using in-app wallet.

## Installation

### Installation Method 1: Download the project template

This method is the easiest way to install Aura SDK. We have all configured Nuget dependencies, customized Android manifests, and made samples for you. The steps are as below:

- Step 1: Clone this repository. If the editor prompts you of importing issues, just "Ignore" it.
- Step 2: Wait for a while. Everything should be all set for you. If they aren't, follow the additional steps below.
- Step 3: Select ```NuGet -> Restore Packages``` to resolve NuGet dependencies.

### Installation Method 2: Download the unitypackage file

This method suits installing Aura SDK to an existing project. It involves downloading and importing the ```.unitypackage``` file, adding package manager and Nuget dependencies, and configure custom Android manifest.

- Step 1: Download and import aura-sdk-unity.unitypackage file in the Releases folder.
- Step 2: Install SocketIOUnity package using the github URL <https://github.com/aura-nw/SocketIOUnity.git>.
- Step 3: Install NuGetForUnity package using the github URL <https://github.com/GlitchEnzo/NuGetForUnity.git?path=/src/NuGetForUnity>.
- Step 4: Install AdvancedPlayerPrefs using the github URL <https://github.com/realphamanhtuan/unity-advanced-playerprefs.git>. This library is used for wallet information encryption.
- Step 5: (Unity <=2021 only) Disable ```Assembly Version Validation``` in the ```Player Settings```. For Unity 2022 or later, this option is disabled by default.
- Step 6: Append these NuGet dependencies into your Assets/packages.config file. If there is no packages.config file in the Assets folder, you can create one and use the content below.

```xml
<?xml version="1.0" encoding="utf-8"?>
<packages>
    <!-- Only append the part below if the file already exists -->
    <package id="BouncyCastle.Cryptography" version="2.2.1" />
    <package id="Microsoft.Bcl.AsyncInterfaces" version="7.0.0" />
    <package id="Microsoft.Extensions.Logging.Abstractions" version="6.0.1" />
    <package id="Microsoft.Extensions.ObjectPool" version="5.0.10" />
    <package id="Microsoft.NETCore.App" version="2.1.0" />
    <package id="NBitcoin.Secp256k1" version="1.0.1" />
    <package id="Newtonsoft.Json" version="12.0.3" />
    <package id="protobuf-net" version="2.3.17" />
    <package id="System.Formats.Asn1" version="6.0.0" />
    <package id="System.Private.ServiceModel" version="4.10.2" />
    <package id="System.Reactive" version="6.0.0" />
    <package id="System.Reflection.TypeExtensions" version="4.4.0" />
    <package id="System.Runtime.CompilerServices.Unsafe" version="6.0" />
    <package id="System.Security.AccessControl" version="6.0.0" />
    <package id="System.Security.Cryptography.Cng" version="5.0.0" />
    <package id="System.Security.Cryptography.Pkcs" version="6.0.1" />
    <package id="System.Security.Cryptography.Xml" version="6.0.1" />
    <package id="System.Security.Principal.Windows" version="5.0.0" />
    <package id="System.ServiceModel.Primitives" version="4.5.3" />
    <package id="System.ServiceModel.Syndication" version="4.5.0" />
    <package id="System.Text.Encoding.CodePages" version="4.5.1" />
    <package id="System.Text.Encodings.Web" version="6.0" />
    <package id="System.Text.Json" version="6.0" />
    <package id="TaskTupleAwaiter" version="1.2.0" />
    <!-- Only append the part above if the file already exists -->
</packages>
```

- Step 7: Select ```NuGet -> Restore Packages``` to resolve NuGet dependencies. Despite being one of the best NuGet package managers for Unity, NuGetForUnity sometimes poses issues in restoring packages. If ```Restore Packages``` doesn't work for you, try ***restarting your Unity Editor***.

- Step 8 (for WebGL builds): When building a package, Unity automatically strips unused managed code for faster loading and running time. For more information on this matter, learn more [here](https://docs.unity3d.com/Manual/ManagedCodeStripping.html). In our SDK, proto-generated files get stripped out when building for WebGL platform. To prevent that from happening, you should either set the ```Managed Stripping Level``` to ```Minimal``` or append (or create if not exists) the ```link.xml``` file in the Assets folder with the content below:


```xml
<!--Assets/link.xml content-->
<linker>
    <assembly fullname="protobuf-net"  preserve="all"/>
</linker>
```

- Step 9: (for Android builds) Turn on Custom Main Manifest and use the content below as ```Assets/Plugins/Android/AndroidManifest.xml``` file

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest
    xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.unity3d.player"
    xmlns:tools="http://schemas.android.com/tools">
    <application>
        <activity android:name="com.DefaultCompany.AuraSDK.ExtendedUnityPlayer"
                  android:theme="@style/UnityThemeSelector">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <meta-data android:name="unityplayer.UnityActivity" android:value="true" />
        </activity>
    </application>
</manifest>
```

## Usage

### Initialize an InApp Wallet

To initialize an InApp wallet, you need a mnemonic phrase and a password (default to an empty string). The mnemonic should look like below.

```plain
garage audit public frown ball tribe dragon outdoor rug point radio funny clean furnace range have hire second use taxi regular mutual other disease
```

Note that this mnemonic phrase is randomly generated for demonstrative purposes only. You should not use this phrase in any real-life operations, because you might lose your money.
For more information on mnemonic code, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki>.

The code below demonstrates the initialization of InApp wallet.

#### Create a random HD Wallet

```csharp
InAppWallet wallet = InAppWallet.CreateRandomHDWallet(password = "");

// get mnemonic of the just-generated wallet
Debug.Log(wallet.mnemonic);
```

Note that if the password isn't specified, an empty string ```""``` will be used.
For more information on how password is used in generating seed and keys, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#user-content-From_mnemonic_to_seed>.

#### Restore HD Wallet using existing mnemonic

```csharp
InAppWallet wallet = InAppWallet.RestoreHDWallet(mnemonic.text);

// get address of the just-imported wallet. Wallet address is a base32 address (alphanumeric excluding '1' (seperator), 'b', 'i' (so not to be confused with 'l'), 'o' (so not to be confused with '0')), prefixed by the human-readable part "aura1", and suffixed by the six-character-long checksum. The address should look like this: aura1jr8x0qy2m9ccp0jslyglnljrgxumvrg4rsvcn4
Debug.Log(wallet.address);
```

Note that if the password isn't specified, an empty string ```""``` will be used.
For more information on how password is used in generating seed and keys, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#user-content-From_mnemonic_to_seed>.

### Check wallet balance

```csharp
BigInteger balance = await wallet.CheckBalance();
```

The balance returned is in the default Aura Denom (defined in Constant.cs), from which you can derive to aura unit by dividing it by 1e6.

### Make a transaction

A transaction is a message that you send to the network in order to perform a specific action. We implement two types of transaction, which are: money sending and contract executing. The code below demonstrates the steps to *create*, *sign*, and *broadcast* a transaction.

```csharp
/// Create a money sending transaction
var tx = await wallet.CreateSendTransaction(toAddress.text, amount.text);

/// SignTransaction will perform the signings and embed the result into the existing tx variable.
await wallet.SignTransaction(tx);

/// BroadcastTx sends the transaction data to the lcd node of Aura Network and returns the http response, from which you can parse the transaction details.
await AuraSDK.InAppWallet.BroadcastTx(tx);
```

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
