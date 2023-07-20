using dotnetstandard_bip39;
using cosmos.tx.v1beta1;
using System.Threading.Tasks;
using System.Numerics;
using AuraSDK.Serialization;
using System.Collections.Generic;
namespace AuraSDK{
    public partial class InAppWallet{
        /// <summary>
        /// Create a random HD Wallet using default strength as Constant.BIP39_STRENGTH and default wordlist as Constant.BIP39_WORDLIST
        /// </summary>
        /// <param name="password">Password to be used along with mnemonic to generate the keys. Default value is an empty string.</param>
        /// <returns>InAppWallet object created by a random mnemonic</returns>
        public static InAppWallet CreateRandomHDWallet(string password = ""){
            BIP39 bIP39 = new BIP39();
            return new InAppWallet(bIP39.GenerateMnemonic(Constant.BIP39_STRENGTH, Constant.BIP39_WORDLIST), password);
        }
        /// <summary>
        /// Restore HD Wallet using mnemonic phrase and a password (if you have one; otherwise, empty string "" will be used as password). It is the same as calling the InAppWallet constructor
        /// </summary>
        /// <param name="mnemonic">Mnemonic phrase that has been generated beforehand. Keys will be derived entirely from this mnemonic and password, along with the Aura derivation path.</param>
        /// <param name="password">Password used along with mnemonic to generate the keys.</param>
        /// <returns>InAppWallet object imported from the mnemonic and password.</returns>
        public static InAppWallet RestoreHDWallet(string mnemonic, string password = ""){
            return new InAppWallet(mnemonic, password);
        }
        ///<summary>Check if the mnemonic is a valid BIP39 mnemonic in Constant.BIP39_WORDLIST wordlist</summary>
        /// <param name="mnemonic">Mnemonic phrase in English</param>
        /// <returns>True if the mnemonic phrase is valid, or False otherwise</returns>
        public static bool CheckMnemonic(string mnemonic){
            BIP39 bIP39 = new BIP39();
            return bIP39.ValidateMnemonic(mnemonic, Constant.BIP39_WORDLIST);
        }

        public static async Task<BigInteger> CheckBalance(string address, string denom){
            try{
                string balanceURL = $"{Constant.LCD_URL}/bank/balances/{address}";
                QueryResponse<List<AuraSDK.Serialization.Coin>> response = await HttpRequest.Get<QueryResponse<List<AuraSDK.Serialization.Coin>>>(balanceURL);
                var result = response.result;
                Logging.Verbose("Balances", response.result.ToArray());
                foreach (var resultItem in response.result){
                    if (resultItem.denom.Equals(denom))
                        return BigInteger.Parse(resultItem.amount);
                }
                Logging.Warning($"Denom {denom} couldn't be found in the coin list. Zero default value was returned.");
                return 0;
            } catch(System.Exception e){
                Logging.Info("Cannot parse coin list with exception:", e);
                return 0;
            }
        }

        [System.Serializable]
        class LcdBroadcastedTx{
            public string tx_bytes;
            public BroadcastMode mode;
        }
        ///<summary>Broadcast a transaction to Aura LCD Endpoint. The transaction should be created and signed before sending; or otherwise, it will be rejected by the server. This function can be used for both SendTransaction and ExecuteContractTransaction</summary>
        /// <param name="signedTx">The Tx transaction that has gone through the creating and the signing process.</param>
        /// <returns>The HttpResponseMessage received from LCD after broadcastingTx.</returns>
        public static async Task<HttpResponse> BroadcastTx(Tx signedTx){
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            ProtoBuf.Serializer.Serialize(memoryStream, signedTx);
            byte[] bytes = memoryStream.ToArray();
            string broadcastURL = $"{Constant.LCD_URL}/cosmos/tx/v1beta1/txs";
            LcdBroadcastedTx broadcastedTx = new LcdBroadcastedTx(){
                tx_bytes = System.Convert.ToBase64String(bytes),
                mode = BroadcastMode.BroadcastModeBlock
            };
            var response = await HttpRequest.Post(broadcastURL,
                new LcdBroadcastedTx(){
                    tx_bytes = System.Convert.ToBase64String(bytes),
                    mode = BroadcastMode.BroadcastModeBlock
                }
            );
            return response;
        }
        public static async Task<HttpResponse> QuerySmartContract(string contractAddress, string queryJson){
            byte[] queryBytes = BitSupporter.ToByteArrayUTF8(queryJson);
            string queryBase64 = System.Convert.ToBase64String(queryBytes);
            string queryURL = $"{Constant.LCD_URL}/cosmwasm/wasm/v1/contract/{contractAddress}/smart/{queryBase64}";
            var response = await HttpRequest.Get(queryURL);
            return response;
        }
    }
}