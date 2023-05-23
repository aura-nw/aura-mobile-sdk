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

namespace AuraMobileSDK{
    public partial class AuraWallet{
        public readonly string mnemonic;
        private readonly byte[] publicKey, privateKey, chainCode;
        public string GetPublicKey(){
            return publicKey.ToHexString();
        }
        public string GetPrivateKey(){
            return privateKey.ToHexString();
        }
        public readonly string address;
        private BaseAccount accountInfo;
        
        ///Constructor: Create an AuraWallet using mnemonic string and a password (if any). Keys are generated using default "Aura derivation path" defined in Constant class.
        public AuraWallet(string mnemonic, string password = ""){
            BIP32 bIP32 = new BIP32();
            BIP39 bIP39 = new BIP39();
            this.mnemonic = mnemonic;
            // Logging.Verbose(System.BitConverter.ToString(bIP39.MnemonicToSeed(mnemonic, password)).Replace("-", "").ToLower());
            (privateKey, chainCode) = bIP32.DerivePath(Constant.DERIVATION_PATH, bIP39.MnemonicToSeed(mnemonic, password));
            publicKey = bIP32.GetPublicKey(privateKey);
            
            byte[] sha256DigestResult = SHA256.Create().ComputeHash(publicKey);
            // Logging.Verbose("sha256Digest:", sha256DigestResult.ToHexString());
            
            var ripeMD160Digest = new Org.BouncyCastle.Crypto.Digests.RipeMD160Digest();
            ripeMD160Digest.BlockUpdate(sha256DigestResult, 0, sha256DigestResult.Length);
            byte[] ripeMD160DigestResult = new byte[20];
            ripeMD160Digest.DoFinal(ripeMD160DigestResult, 0);

            // Logging.Verbose("ripeMD160Digest:", ripeMD160DigestResult.ToHexString());
            address = Bech32.Bech32Engine.Encode(Constant.BECH32_HRP, ripeMD160DigestResult);
            // Logging.Verbose("Address:", Bech32.Bech32Engine.Encode(Constant.BECH32_HRP, ripeMD160DigestResult));
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
        public async Task<System.Numerics.BigInteger> GetBalance(){
            try{
                var balance = await cosmosApiClient.Bank.GetBankBalancesByAddressAsync(address);
                var result = balance.Result;
                return result[0].Amount;
            } catch(System.Exception e){
                //Logging.Error(e);
                return 0;
            }
        }
        public async Task<Tx> CreateTransaction(string toAddress, string sendAmount, string feeAmount = "200"){
            TxBody txBody = new TxBody(){
                Memo = GenerateRandomMemo()
            };
            txBody.Messages.Add(Google.Protobuf.WellKnownTypes.Any.Pack(CreateSendMessage(address, toAddress, sendAmount), "/cosmos.bank.v1beta1.MsgSend"));

            AuthInfo authInfo = new AuthInfo(){
                Fee = CreateFee(address, toAddress, feeAmount)
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
        public async Task SignTransaction(Tx tx){
            SignDoc signDoc = new SignDoc(){
                BodyBytes = Google.Protobuf.WellKnownTypes.Any.Pack(tx.Body).Value,
                AuthInfoBytes = Google.Protobuf.WellKnownTypes.Any.Pack(tx.AuthInfo).Value,
                AccountNumber = await GetAccountNumber(),
                ChainId = Constant.CHAIN_ID
            };
            byte[] bytesToSign = Google.Protobuf.WellKnownTypes.Any.Pack(signDoc).Value;
            //Logging.Verbose("bytesToSign", bytesToSign, System.Text.Encoding.ASCII.GetString(bytesToSign));
            CosmosApi.Crypto.CosmosCryptoService cryptoService = new CosmosApi.Crypto.CosmosCryptoService();
            byte[] signature = cryptoService.Sign(bytesToSign, cryptoService.ParsePrivateKey(privateKey));
            //Logging.Verbose("signature", signature, System.Text.Encoding.ASCII.GetString(signature));
            tx.Signatures.Add(signature);
        }
    }
}