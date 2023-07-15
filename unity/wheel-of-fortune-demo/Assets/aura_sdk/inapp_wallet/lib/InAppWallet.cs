using dotnetstandard_bip39;
using dotnetstandard_bip32;
using cosmos.tx.v1beta1;
using cosmos.crypto.secp256k1;
using System.Security.Cryptography;
using System.Threading.Tasks;
using System.Collections.Generic;
using AuraSDK.Serialization;
using System.Numerics;
using cosmos._base.v1beta1;
using cosmos.bank.v1beta1;
using cosmwasm.wasm.v1;

namespace AuraSDK{
    public partial class InAppWallet{
        ///<summary>The mnemonic that was used to construct this InAppWallet object. The mnemonic can't be changed once initialized. To change the mnemonic, create a new InAppWallet object</summary>
        public readonly string mnemonic;
        private readonly byte[] publicKey, privateKey, chainCode;
        /// <summary>
        /// Return wallet public key derived from Constant.DERIVATION_PATH using BIP32 and BIP44 standard. The key is in hex string format, similar to the format used by coin98 wallet
        /// </summary>
        /// <returns>A hex string representing the byte data of the wallet's Public Key</returns>
        public string GetPublicKey(){
            return publicKey.ToHexString();
        }
        /// <summary>
        /// Return wallet private key derived from Constant.DERIVATION_PATH using BIP32 standard. The key is in hex string format, similar to the format used by coin98 wallet
        /// </summary>
        /// <returns>A hex string representing the byte data of the wallet's Private Key</returns>
        public string GetPrivateKey(){
            return privateKey.ToHexString();
        }
        ///<summary>Cosmos-style wallet address, derived from GetPublicKey() result using GetAddress(pub) = BECH32(RIPEMD160(SHA256(pub))) digest function</summary>
        public readonly string address;
        private BaseAccount accountInfo;
        
        /// <summary>
        /// Constructor: Create an InAppWallet using mnemonic string and a password (if you have any). Mnemonic will be generated using RFC2898 standard using SHA512 function with the following parameters: password = GetBytes(mnemonic), salt = "mnemonic" + your_password, iterations = 2048. Public and Private Keys are generated using default "Aura derivation path" defined in Constant class.
        /// </summary>
        /// <param name="mnemonic">A twelve-word phrase compatible with BIP39 specification.</param>
        /// <param name="password">A password used along with mnemonic to generate the root key's seed. Empty string "" will be used as default.</param>
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
        }
        private async Task<BaseAccount> GetAccountInfo(){
            string getAccountInfoURL = $"{Constant.LCD_URL}/auth/accounts/{address}";
            BaseAccount accountInfo = (await 
                                    HttpRequest.Get<QueryResponse<TypeValue<BaseAccount>>>(getAccountInfoURL))
                                    .result.value;

            if (accountInfo == null)
                Logging.Warning("Cannot fetch account info, using cached data.");
            else 
                this.accountInfo = accountInfo;
            return this.accountInfo;
        }
        private async Task<ulong> GetAccountSequence(){
            BaseAccount accountInfo = await GetAccountInfo();
            return accountInfo.sequence;
        }
        private async Task<ulong> GetAccountNumber(){
            BaseAccount accountInfo = await GetAccountInfo();
            return accountInfo.accountNumber;
        }
        /// <summary>
        /// Get Balance for the this.address address. This is an awaitable function and will return 0 if error occurs
        /// </summary>
        /// <param name="denom">The denom in which you want to get balance, for example, "uaura".</param>
        /// <returns>Balance in denom as a BigInteger</returns>
        public async Task<BigInteger> CheckBalance(string denom){
            return await InAppWallet.CheckBalance(address, denom);
        }
        private async Task<Serialization.TransactionList> SearchTransaction(string events, int limit){
            string searchURL =  $"{Constant.LCD_URL}/cosmos/tx/v1beta1/txs" + 
                                $"?events={events}" +
                                $"?pagination.offset=0" + 
                                $"?pagination.limit={limit}";
            return await HttpRequest.Get<Serialization.TransactionList>(searchURL);
        }
        private async Task<List<AuraTransaction>> CheckWalletHistory(int limit = 100){
            List<AuraTransaction> transactionHistory = new List<AuraTransaction>();
            
            Serialization.TransactionList sendList = await SearchTransaction(System.Uri.EscapeUriString($"transfer.sender='{address}'"), 100);

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
            
            Serialization.TransactionList receiveList = await SearchTransaction(System.Uri.EscapeUriString($"transfer.sender='{address}'"), 100);

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

        #region transaction
        ///<summary> Create a fee in Constant.AURA_DENOM. Note that the fee is always in Constant.AURA_DENOM denom, defined in the Constant class </summary>
        private Fee CreateFee(string payer, string granter, string amount){
            Fee fee = new Fee() {
                GasLimit = Constant.GAS_LIMIT,
                Payer = payer,
                Granter = granter
            };
            fee.Amounts.Add(new cosmos._base.v1beta1.Coin() {
                Denom = Constant.AURA_DENOM,
                Amount = amount
            });
            return fee;
        }
        
        private string GenerateRandomMemo(){
            return System.Guid.NewGuid().ToString("D");
        }

        private MsgSend CreateSendMessage(string fromAddress, string toAddress, string denom, string amount){
            MsgSend msgSend = new MsgSend(){
                FromAddress = fromAddress,
                ToAddress = toAddress,
            };
            msgSend.Amounts.Add(new cosmos._base.v1beta1.Coin() {
                Denom = denom,
                Amount = amount
            });
            return msgSend;
        }
        /// <summary>
        /// Create a transaction with a MsgSend message. The returned Tx structured is defined in proto-generated code cosmos.tx.v1beta1.tx
        /// </summary>
        /// <param name="toAddress">Bech32-compatible address to which you send the coin.</param>
        /// <param name="sendDenom">The type of coin you are sending, for example, uaura.</param>
        /// <param name="sendAmount">The amount of coin in sendDenom you are sending.</param>
        /// <param name="feeAmount">The amount of coins to be paid as a fee. Along with GAS_LIMIT, this yields an effective gasprice, which needs to be above some limit to be accepted into the mempool.</param>
        /// <returns>Tx object representing the just-created transaction.</returns>
        public async Task<Tx> CreateSendTransaction(string toAddress, string sendDenom, string sendAmount, string feeAmount = "200"){
            TxBody txBody = new TxBody(){
                Memo = GenerateRandomMemo()
            };
            txBody.Messages.Add(
                Google.Protobuf.WellKnownTypes.Any.Pack(
                    CreateSendMessage(
                        address, 
                        toAddress, 
                        sendDenom, 
                        sendAmount
                    ), 
                    "/cosmos.bank.v1beta1.MsgSend"
                )
            );

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
                PublicKey = Google.Protobuf.WellKnownTypes.Any.Pack(
                    new PubKey(){
                        Key = this.publicKey
                    },
                    "/cosmos.crypto.secp256k1.PubKey"
                )
            });

            Tx tx = new Tx(){
                Body = txBody,
                AuthInfo = authInfo,
                
            };

            return tx;
        }
        
        private MsgExecuteContract CreateExecuteContractMessage(string senderAddress, string contractAddress, byte[] msgToSendToContract, string fundsDenom, string fundsAmount = null){
            MsgExecuteContract msgExecuteContract = new MsgExecuteContract() {
                Sender = senderAddress,
                Contract = contractAddress
            };

            if (fundsDenom != null && fundsAmount != null)
                msgExecuteContract.Funds.Add(new cosmos._base.v1beta1.Coin() {
                    Denom = fundsDenom,
                    Amount = fundsAmount
                });

            msgExecuteContract.Msg = msgToSendToContract;
            return msgExecuteContract;
        }
        /// <summary>
        /// Create a transaction with a MsgExecuteContract message. The returned Tx structured is defined in proto-generated code cosmos.tx.v1beta1.tx
        /// </summary>
        /// <param name="contractAddress">The address of the contract with which you try to interact.</param>
        /// <param name="msgJson">The message in JSON format to send to the contract.</param>
        /// <param name="fundsDenom">The denom of the funds you send along with the message to the smart contract.</param>
        /// <param name="feeAmount">The fund amount to send to the smart contract.</param>
        /// <returns>Tx object representing the just-created transaction.</returns>
        public async Task<Tx> CreateExecuteContractTransaction(string contractAddress, string msgJson, string fundsDenom = null, string fundsAmount = null, string feeAmount = "200"){
            TxBody txBody = new TxBody(){
                Memo = GenerateRandomMemo()
            };
            txBody.Messages.Add(
                Google.Protobuf.WellKnownTypes.Any.Pack(
                    CreateExecuteContractMessage(
                        address, 
                        contractAddress, 
                        BitSupporter.ToByteArrayUTF8(msgJson), 
                        fundsDenom, 
                        fundsAmount), 
                    "/cosmwasm.wasm.v1.MsgExecuteContract"
                )
            );

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
                PublicKey = Google.Protobuf.WellKnownTypes.Any.Pack(
                    new PubKey(){
                        Key = this.publicKey
                    },
                    "/cosmos.crypto.secp256k1.PubKey"
                )
            });

            Tx tx = new Tx(){
                Body = txBody,
                AuthInfo = authInfo,
            };

            return tx;
        }
        /// <summary>
        /// Sign existing transaction using the cosmos.tx.signing.v1beta1.SignMode.SignModeDirect mode. The signature will be appended directly to the passed-in Tx and the signing process will use existing account private key
        /// </summary>
        /// <param name="tx">Tx object that was created by CreateSendTransaction() or CreateExecuteContractTransaction() function.</param>
        /// <returns>Nothing, the signature will be appended directly into the Tx object</returns>
        public async Task SignTransaction(Tx tx){
            SignDoc signDoc = new SignDoc(){
                BodyBytes = Google.Protobuf.WellKnownTypes.Any.Pack(tx.Body).Value,
                AuthInfoBytes = Google.Protobuf.WellKnownTypes.Any.Pack(tx.AuthInfo).Value,
                AccountNumber = await GetAccountNumber(),
                ChainId = Constant.CHAIN_ID
            };
            byte[] bytesToSign = Google.Protobuf.WellKnownTypes.Any.Pack(signDoc).Value;
            byte[] signature = SignatureProvider.Sign(bytesToSign, privateKey);
            tx.Signatures.Add(signature);
        }
        #endregion
    }
}