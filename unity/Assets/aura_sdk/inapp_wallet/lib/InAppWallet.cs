using dotnetstandard_bip39;
using dotnetstandard_bip32;
using cosmos.tx.v1beta1;
using cosmos._base.v1beta1;
using cosmos.bank.v1beta1;
using cosmos.tx.signing.v1beta1;
using System.Security.Cryptography;
using System.Threading.Tasks;
using CosmosApi.Models;
using Flurl.Http;
using cosmwasm.wasm.v1;
using Newtonsoft.Json;
using System.Collections.Generic;
namespace AuraSDK{
    public partial class InAppWallet{
        ///<summary>The mnemonic that was used to construct this InAppWallet object. The mnemonic can't be changed once initialized. To change the mnemonic, create a new InAppWallet object</summary>
        public readonly string mnemonic;
        private readonly byte[] publicKey, privateKey, chainCode;
        ///<summary>Return wallet public key derived from <paramref name="Constant.DERIVATION_PATH"> using BIP32 and BIP44 standard. The key is in hex string format, similar to the format used by coin98 wallet
        public string GetPublicKey(){
            return publicKey.ToHexString();
        }
        ///<summary>Return wallet private key derived from <paramref name="Constant.DERIVATION_PATH"> using BIP32 standard. The key is in hex string format, similar to the format used by coin98 wallet
        public string GetPrivateKey(){
            return privateKey.ToHexString();
        }
        ///<summary>Return cosmos-style wallet address, derived from GetPublicKey() result using GetAddress(pub) = BECH32(RIPEMD160(SHA256(pub))) digest function
        public readonly string address;
        private BaseAccount accountInfo;
        
        /// <summary> Constructor: Create an InAppWallet using mnemonic string and a password (if you have any). Mnemonic will be generated using RFC2898 standard using SHA512 function with the following parameters: password = GetBytes(mnemonic), salt = "mnemonic" + your_password, iterations = 2048
        /// Public and Private Keys are generated using default "Aura derivation path" defined in Constant class. </summary>
        public InAppWallet(string mnemonic, string password = ""){
            BIP32 bIP32 = new BIP32();
            BIP39 bIP39 = new BIP39();
            this.mnemonic = mnemonic;
            (privateKey, chainCode) = bIP32.DerivePath(Constant.DERIVATION_PATH, bIP39.MnemonicToSeedHex(mnemonic, password));
            publicKey = bIP32.GetPublicKey(privateKey);
            
            byte[] sha256DigestResult = SHA256.Create().ComputeHash(publicKey);
            
            var ripeMD160Digest = new Org.BouncyCastle.Crypto.Digests.RipeMD160Digest();
            ripeMD160Digest.BlockUpdate(sha256DigestResult, 0, sha256DigestResult.Length);
            byte[] ripeMD160DigestResult = new byte[20];
            ripeMD160Digest.DoFinal(ripeMD160DigestResult, 0);

            address = Bech32.Bech32Engine.Encode(Constant.BECH32_HRP, ripeMD160DigestResult);
            Logging.Verbose("Wallet imported with following information:",
                            "\nmnemonic:", mnemonic,
                            "\nprivateKey:", GetPrivateKey(),
                            "\npublicKey:", GetPublicKey(),
                            "\nchainCode:", chainCode.ToHexString(),
                            "\naddress:", address
            );
        }
        private async Task<BaseAccount> GetAccountInfo(){
            BaseAccount accountInfo = ((await cosmosApiClient.Auth.GetAuthAccountByAddressAsync(address)).Result as CosmosApi.Models.BaseAccount);
            if (accountInfo == null)
                Logging.Warning("Cannot fetch account info, using cached data.");
            else 
                this.accountInfo = accountInfo;
            return this.accountInfo;
        }
        private async Task<ulong> GetAccountSequence(){
            BaseAccount accountInfo = await GetAccountInfo();
            return accountInfo.Sequence;
        }
        private async Task<ulong> GetAccountNumber(){
            BaseAccount accountInfo = await GetAccountInfo();
            return accountInfo.AccountNumber;
        }
        ///<summary>Get Balance for the this.address address. This is an awaitable function and will return 0 if error occurs</summary>
        public async Task<System.Numerics.BigInteger> CheckBalance(){
            try{
                var balance = await cosmosApiClient.Bank.GetBankBalancesByAddressAsync(address);
                var result = balance.Result;
                return result[0].Amount;
            } catch(System.Exception e){
                Logging.Error(e);
                return 0;
            }
        }
        private async Task<LCDTransactionList> SearchTransaction(string events, int limit){
            return await flurlClient
                .Request("cosmos", "tx", "v1beta1", "txs")
                .SetQueryParam("events", events)
                .SetQueryParam("pagination.offset", 0)
                .SetQueryParam("pagination.limit", limit).
                GetJsonAsync<LCDTransactionList>();
        }
        public async Task<List<AuraTransaction>> CheckWalletHistory(int limit = 100){
            List<AuraTransaction> transactionHistory = new List<AuraTransaction>();
            
            LCDTransactionList sendList = await SearchTransaction(System.Uri.EscapeUriString($"transfer.sender='{address}'"), 100);

            for (int i = 0; i < sendList.transactions.Length; ++i){
                var transaction = sendList.transactions[i];
                var transactionResponse = sendList.transactionResponses[i];

                if (transaction.body.messages[0].type == "/cosmos.bank.v1beta1.MsgSend"){
                    transactionHistory.Add(new AuraTransaction() {
                        type = TransactionType.SEND,
                        fromAddress = transaction.body.messages[0].fromAddress,
                        toAddress = transaction.body.messages[0].toAddress,
                        timestamp = transactionResponse.timestamp,
                        amount = transaction.body.messages[0].amount[0].amount
                    });
                }
            }
            
            LCDTransactionList receiveList = await SearchTransaction(System.Uri.EscapeUriString($"transfer.sender='{address}'"), 100);

            for (int i = 0; i < receiveList.transactions.Length; ++i){
                var transaction = receiveList.transactions[i];
                var transactionResponse = receiveList.transactionResponses[i];

                if (transaction.body.messages[0].type == "/cosmos.bank.v1beta1.MsgSend"){
                    transactionHistory.Add(new AuraTransaction() {
                        type = TransactionType.SEND,
                        fromAddress = transaction.body.messages[0].fromAddress,
                        toAddress = transaction.body.messages[0].toAddress,
                        timestamp = transactionResponse.timestamp,
                        amount = transaction.body.messages[0].amount[0].amount
                    });
                }
            }

            return transactionHistory;
        }
        ///<summary>Create a transaction with a MsgSend message. The returned Tx structured is defined in proto-generated code cosmos.tx.v1beta1.tx</summary>
        public async Task<Tx> CreateSendTransaction(string toAddress, string sendAmount, string feeAmount = "200"){
            TxBody txBody = new TxBody(){
                Memo = GenerateRandomMemo()
            };
            txBody.Messages.Add(Google.Protobuf.WellKnownTypes.Any.Pack(CreateSendMessage(address, toAddress, sendAmount), "/cosmos.bank.v1beta1.MsgSend"));

            AuthInfo authInfo = new AuthInfo(){
                Fee = CreateFee(address, address, feeAmount)
            };
            authInfo.SignerInfos.Add(new SignerInfo() {
                ModeInfo = new ModeInfo(){
                    single = new ModeInfo.Single(){
                        Mode = cosmos.tx.signing.v1beta1.SignMode.SignModeDirect
                    }
                }, 
                Sequence = await GetAccountSequence(),
            });

            Tx tx = new Tx(){
                Body = txBody,
                AuthInfo = authInfo,
                
            };

            return tx;
        }
        ///<summary>Create a transaction with a MsgExecuteContract message. The returned Tx structured is defined in proto-generated code cosmos.tx.v1beta1.tx</summary>
        public async Task<Tx> CreateExecuteContractTransaction(string contractAddress, string msgJson, string funds = null, string feeAmount = "200"){
            TxBody txBody = new TxBody(){
                Memo = GenerateRandomMemo()
            };
            txBody.Messages.Add(Google.Protobuf.WellKnownTypes.Any.Pack(CreateExecuteContractMessage(address, contractAddress, BitSupporter.ToByteArrayUTF8(msgJson), funds), "/cosmwasm.wasm.v1.MsgExecuteContract"));

            AuthInfo authInfo = new AuthInfo(){
                Fee = CreateFee(address, address, feeAmount)
            };
            authInfo.SignerInfos.Add(new SignerInfo() {
                ModeInfo = new ModeInfo(){
                    single = new ModeInfo.Single(){
                        Mode = cosmos.tx.signing.v1beta1.SignMode.SignModeDirect
                    }
                }, 
                Sequence = await GetAccountSequence(),
            });

            Tx tx = new Tx(){
                Body = txBody,
                AuthInfo = authInfo,
            };

            return tx;
        }
        ///<summary>Sign existing transaction using the <paramref name="cosmos.tx.signing.v1beta1.SignMode.SignModeDirect"> mode. The signature will be appended directly to the passed-in Tx and the signing process will use existing account private key</summary>
        public async Task SignTransaction(Tx tx){
            SignDoc signDoc = new SignDoc(){
                BodyBytes = Google.Protobuf.WellKnownTypes.Any.Pack(tx.Body).Value,
                AuthInfoBytes = Google.Protobuf.WellKnownTypes.Any.Pack(tx.AuthInfo).Value,
                AccountNumber = await GetAccountNumber(),
                ChainId = Constant.CHAIN_ID
            };
            byte[] bytesToSign = Google.Protobuf.WellKnownTypes.Any.Pack(signDoc).Value;
            CosmosApi.Crypto.CosmosCryptoService cryptoService = new CosmosApi.Crypto.CosmosCryptoService();
            byte[] signature = cryptoService.Sign(bytesToSign, cryptoService.ParsePrivateKey(privateKey));
            tx.Signatures.Add(signature);
        }
    }
}