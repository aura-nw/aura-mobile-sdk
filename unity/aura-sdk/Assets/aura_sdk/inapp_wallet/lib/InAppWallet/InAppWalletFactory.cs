using dotnetstandard_bip39;
using cosmos.tx.v1beta1;
using System.Threading.Tasks;
using System.Numerics;
using AuraSDK.Serialization;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace AuraSDK{
    public partial class InAppWallet{
        /// <summary>
        /// Create a random HD Wallet using default strength as Constant.BIP39_STRENGTH and default wordlist as Constant.BIP39_WORDLIST
        /// </summary>
        /// <param name="passphrase">Passphrase to be used along with mnemonic to generate the keys. Default value is an empty string.</param>
        /// <returns>InAppWallet object created by a random mnemonic</returns>
        public static InAppWallet CreateRandomHDWallet(string passphrase = ""){
            BIP39 bIP39 = new BIP39();
            return new InAppWallet(bIP39.GenerateMnemonic(Constant.BIP39_STRENGTH, Constant.BIP39_WORDLIST), passphrase);
        }
        /// <summary>
        /// Restore HD Wallet using mnemonic phrase and a passphrase (if you have one; otherwise, empty string "" will be used as passphrase). It is the same as calling the InAppWallet constructor
        /// </summary>
        /// <param name="mnemonic">Mnemonic phrase that has been generated beforehand. Keys will be derived entirely from this mnemonic and passphrase, along with the Aura derivation path.</param>
        /// <param name="passphrase">Passphrase used along with mnemonic to generate the keys.</param>
        /// <returns>InAppWallet object imported from the mnemonic and passphrase.</returns>
        public static InAppWallet RestoreHDWallet(string mnemonic, string passphrase = ""){
            return new InAppWallet(mnemonic, passphrase);
        }
        ///<summary>Check if the mnemonic is a valid BIP39 mnemonic in Constant.BIP39_WORDLIST wordlist</summary>
        /// <param name="mnemonic">Mnemonic phrase in English</param>
        /// <returns>True if the mnemonic phrase is valid, or False otherwise</returns>
        public static bool CheckMnemonic(string mnemonic){
            BIP39 bIP39 = new BIP39();
            return bIP39.ValidateMnemonic(mnemonic, Constant.BIP39_WORDLIST);
        }

        public static async Task<(bool success, System.Exception error, BigInteger balance)> CheckBalance(string address, string denom){
            try{
                string balanceURL = Constant.LCD_URL + string.Format(Constant.API_GET_BALANCE, address, denom);
                HttpResponse response = await HttpRequest.Get(balanceURL);

                if (response.StatusCode == 200){
                    JObject resObj = JObject.Parse(response.Content);

                    if (resObj.ContainsKey("balance")){
                        JObject balance = (JObject) resObj["balance"];
                        if (balance.ContainsKey("denom") && balance.ContainsKey("amount")){
                            // balance["denom"].ToString() should be used instead of SerializeToString(), 
                            // because SerializeToString() results in "ueaura" with quotes, while ToString() gives ueaura without quotes.

                            if (balance["denom"].ToString().Equals(denom)){
                                BigInteger ret = BigInteger.Parse(balance["amount"].ToString());
                                return (success: true, error: null, balance: ret);
                            }
                        } 
                    } 
                    
                    if (resObj.ContainsKey("balances")){
                        JArray balances = (JArray) resObj["balances"];
                        for (int i = 0; i < balances.Count; ++i){
                            JObject balance = (JObject) balances[i];
                            if (balance.ContainsKey("denom") && balance.ContainsKey("amount")){
                                // balance["denom"].ToString() should be used instead of SerializeToString(), 
                                // because SerializeToString() results in "ueaura" with quotes, while ToString() gives ueaura without quotes.
                                
                                if (balance["denom"].ToString().Equals(denom)){
                                    BigInteger ret = BigInteger.Parse(balance["amount"].ToString());
                                    return (success: true, error: null, balance: ret);
                                }
                            } 
                        }
                    }

                    return (success: false, error: new System.Exception($"Can't find denom {denom} in the balance list."), balance: 0);
                } else {
                    return (success: false, error: new System.Exception($"Request failed for {balanceURL}"), balance: 0);
                }
            } catch(System.Exception e){
                return (success: false, error: e, balance: 0);
            }
        }
        
        ///<summary>Broadcast a transaction to Aura LCD Endpoint. The transaction should be created and signed before sending; or otherwise, it will be rejected by the server. This function can be used for both SendTransaction and ExecuteContractTransaction</summary>
        /// <param name="signedTx">The Tx transaction that has gone through the creating and the signing process.</param>
        /// <returns>The HttpResponseMessage received from LCD after broadcastingTx.</returns>
        public static async Task<HttpResponse> BroadcastTx(Tx signedTx){
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            ProtoBuf.Serializer.Serialize(memoryStream, signedTx);
            byte[] bytes = memoryStream.ToArray();
            string broadcastURL = $"{Constant.LCD_URL}{Constant.API_BROADCAST_TX}";

            var response = await HttpRequest.Post(broadcastURL,
                new {
                    tx_bytes = System.Convert.ToBase64String(bytes),
                    mode = BroadcastMode.BroadcastModeSync
                }
            );
            return response;
        }

        /// <summary>Broadcast a transaction in Sync mode to get its txhash. This function then checks the transaction status every 5 seconds until it is processed. The function returns the final HTTP response, which contains the code produced by the network at 'httpResponse.tx_response.code'</summary>
        /// <remarks>This function is not recommended. For more control over the process, use BroadcastTx which doesn't wait for transaction confirmation, and manually check transaction status.</remarks>
        /// <param name="signedTx">The Tx transaction that has gone through the creating and the signing process.</param>
        /// <returns>The HttpResponseMessage received from LCD after transaction confirmation</returns>
        public static async Task<(bool success, System.Exception error, HttpResponse response)> BroadcastTxBlock(Tx signedTx, int checkDelayMs = 5000, int maxCheckRetries = 5){
            var response = await BroadcastTx(signedTx);
            if (response.StatusCode != 200) return (false, new System.Exception($"Cannot broadcast Tx. Response: {response.StatusCode}, {response.Content}"), response);
            
            try{
                JObject resObj = JObject.Parse(response.Content);
                string txhash = resObj["tx_response"]["txhash"].ToString();

                int checkCount = 0;
                while (checkCount < maxCheckRetries) {
                    // Check if the transaction is completed or not
                    var txCheckResponse = await AuraSDK.InAppWallet.QueryTransactionDetails(txhash);

                    if (txCheckResponse.StatusCode == 200){
                        JObject txDetails = JObject.Parse(txCheckResponse.Content);

                        ulong height;
                        if (ulong.TryParse(txDetails["tx_response"]["height"].ToString(), out height) && height > 0){
                            //transaction included in some block
                            ulong code;

                            if (ulong.TryParse(txDetails["tx_response"]["code"].ToString(), out code) && code > 0){
                                Logging.Error("Transaction failed. Code =", code);
                                return (false, new System.Exception($"Transaction processing failed. Code: {code}"), txCheckResponse);
                            } else {
                                Logging.Info("Transaction successful. Height =", height);
                                return (true, null, txCheckResponse);
                            }
                        }
                    } 
                    
                    // increase the checkCount
                    ++checkCount;
                    
                    // delay for checkDelayMs miliseconds before making the next call
                    await System.Threading.Tasks.Task.Delay(checkDelayMs);
                }

                return (false, new System.Exception($"Transaction is yet to complete after {maxCheckRetries} tries."), response);
            } catch (System.Exception e){
                return (false, e, response);
            }
        }

        ///<summary>Broadcast a transaction to Aura LCD Endpoint. The transaction should be created and signed before sending; or otherwise, it will be rejected by the server. This function can be used for both SendTransaction and ExecuteContractTransaction</summary>
        /// <param name="signedTx">The Tx transaction that has gone through the creating and the signing process.</param>
        /// <returns>The HttpResponseMessage received from LCD after broadcastingTx.</returns>
        public static async Task<HttpResponse> SimulateTx(Tx signedTx){
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            ProtoBuf.Serializer.Serialize(memoryStream, signedTx);
            byte[] bytes = memoryStream.ToArray();
            string broadcastURL = $"{Constant.LCD_URL}{Constant.API_SIMULATE_TX}";

            var response = await HttpRequest.Post(broadcastURL,
                new {
                    tx_bytes = System.Convert.ToBase64String(bytes)
                }
            );
            return response;
        }

        /// <summary>
        /// Check the status of transaction after sending, using txHash
        /// </summary>
        /// <param name="txHash"></param>
        /// <returns></returns>
        public static async Task<HttpResponse> QueryTransactionDetails(string txHash){
            string queryURL = Constant.LCD_URL + string.Format(Constant.API_QUERY_TX_DETAILS, txHash);
            // Logging.Verbose(queryURL);
            var response = await HttpRequest.Get(queryURL);
            return response;
        }

        public static async Task<HttpResponse> QuerySmartContract(string contractAddress, string queryJson){
            byte[] queryBytes = BitSupporter.ToByteArrayUTF8(queryJson);
            string queryBase64 = System.Convert.ToBase64String(queryBytes);
            string queryURL = Constant.LCD_URL + string.Format(Constant.API_QUERY_SMART_CONTRACT, contractAddress, queryBase64);
            var response = await HttpRequest.Get(queryURL);
            return response;
        }
    }
}