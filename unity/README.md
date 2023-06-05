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
- Step 2: Install SocketIOUnity package using the github URL <https://github.com/aura-nw/SocketIOUnity.git>
- Step 3: Install NuGetForUnity package using the github URL <https://github.com/GlitchEnzo/NuGetForUnity.git?path=/src/NuGetForUnity>
- Step 4: Append these NuGet dependencies into your Assets/packages.config file

```xml
<package id="BouncyCastle.NetCore" version="1.8.6" />
  <package id="dotnetstandard-bip39" version="1.0.2" />
  <package id="ExtendedNumerics.BigDecimal" version="2023.121.1953" />
  <package id="Flurl" version="2.8.2" />
  <package id="Flurl.Http" version="2.4.2" />
  <package id="JsonSubTypes" version="1.7.0" />
  <package id="Microsoft.Bcl.AsyncInterfaces" version="7.0.0" />
  <package id="Microsoft.Extensions.Logging.Abstractions" version="6.0.1" />
  <package id="Microsoft.NETCore.App" version="2.1.0" />
  <package id="NaCl.Net" version="0.1.6-pre" />
  <package id="NBitcoin.Secp256k1" version="1.0.1" />
  <package id="Newtonsoft.Json" version="12.0.3" />
  <package id="protobuf-net" version="3.2.16" />
  <package id="protobuf-net.Core" version="3.2.16" />
  <package id="System.Buffers" version="4.5.1" />
  <package id="System.Buffers" version="4.5.1" />
  <package id="System.Collections.Immutable" version="7.0.0" />
  <package id="System.Memory" version="4.5.5" />
  <package id="System.Numerics.Vectors" version="4.5.0" />
  <package id="System.Reactive" version="6.0.0" />
  <package id="System.Runtime.CompilerServices.Unsafe" version="6.0" />
  <package id="System.Text.Encoding.CodePages" version="4.5.1" />
  <package id="System.Text.Encodings.Web" version="6.0" />
  <package id="System.Text.Json" version="6.0" />
  <package id="System.Threading.Tasks.Extensions" version="4.5.4" />
  <package id="TaskTupleAwaiter" version="1.2.0" />
```

- Step 5: Select ```NuGet -> Restore Packages``` to resolve NuGet dependencies.
- Step 6: (Android additionals) Turn on Custom Main Manifest and use the content below as ```Assets/Plugins/Android/AndroidManifest.xml``` file

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

To initialize an InApp wallet, there you need a mnemonic phrase and a password (default to an empty string). The mnemonic should look like this

```plain
garage audit public frown ball tribe dragon outdoor rug point radio funny clean furnace range have hire second use taxi regular mutual other disease
```

Note that this mnemonic phrase is randomly generated for demonstrative purposes only. You should not use this phrase in any real-life operations, because you might lose your money.
For more information on mnemonic code, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki>

The code below demonstrates the initialization of InApp wallet.

#### Create a random HD Wallet

```csharp
InAppWallet wallet = InAppWallet.CreateRandomHDWallet(password = "");

// get mnemonic of the just-generated wallet
Debug.Log(wallet.mnemonic);
```
Note that if the password isn't specified, an empty string ```""``` will be used.
For more information on how password is used in generating seed and keys, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#user-content-From_mnemonic_to_seed>

#### Restore HD Wallet using existing mnemonic

```csharp
InAppWallet wallet = InAppWallet.RestoreHDWallet(mnemonic.text);

// get address of the just-imported wallet
Debug.Log(wallet.address);
```

Note that if the password isn't specified, an empty string ```""``` will be used.
For more information on how password is used in generating seed and keys, refer to <https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#user-content-From_mnemonic_to_seed>

### Check wallet balance

```csharp
BigInteger balance = await DemoIAW.wallet.CheckBalance();
```

The balance returned is in uaura, from which you can derive to aura unit by dividing it by 1e6.

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

```csharp
/// Create a contract executing transaction
Tx tx = await wallet.CreateExecuteContractTransaction(
    //contract address
    "aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx",
    //message
    "{\"transfer_nft\": {\"recipient\": \"aura1k24l7vcfz9e7p9ufhjs3tfnjxwu43h8quq4glv\",\"token_id\": \"2\"}}"
);

/// SignTransaction will perform the signings and embed the result into the existing tx variable.
await wallet.SignTransaction(tx);

/// BroadcastTx sends the transaction data to the lcd node of Aura Network and returns the http response, from which you can parse the transaction details.
await AuraSDK.InAppWallet.BroadcastTx(tx);
```

### View transaction history

The code below shows how you can query transaction history and print it out to the log.

```csharp
List<AuraTransaction> transactionHistory = await wallet.CheckWalletHistory();
foreach(AuraTransaction transaction in transactionHistory){
    Debug.Log($"{transaction.type}: {transaction.fromAddress} -> {transaction.toAddress} {transaction.amount} uaura\n");
}
```

