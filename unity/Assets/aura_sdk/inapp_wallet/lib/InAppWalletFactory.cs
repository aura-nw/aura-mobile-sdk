using dotnetstandard_bip39;
using cosmos.tx.v1beta1;
using cosmos._base.v1beta1;
using cosmos.bank.v1beta1;
using System.Threading.Tasks;
using Flurl.Http;
using cosmwasm.wasm.v1;
namespace AuraSDK{
    public partial class InAppWallet{
        private static readonly Flurl.Http.FlurlClient flurlClient;
        static InAppWallet(){
            flurlClient = new Flurl.Http.FlurlClient(Constant.LCD_URL);
        }
        /// <summary>
        /// Create a random HD Wallet using default strength as <paramref name="Constant.BIP39_STRENGTH"> and default wordlist as <paramref name="Constant.BIP39_WORDLIST">
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
        ///<summary>Check if the mnemonic is a valid BIP39 mnemonic in <paramref name="Constant.BIP39_WORDLIST"> wordlist</summary>
        /// <param name="mnemonic">Mnemonic phrase in English</param>
        /// <returns>True if the mnemonic phrase is valid, or False otherwise</returns>
        public static bool CheckMnemonic(string mnemonic){
            BIP39 bIP39 = new BIP39();
            return bIP39.ValidateMnemonic(mnemonic, Constant.BIP39_WORDLIST);
        }
        [System.Serializable]
        class LcdBroadcastedTx{
            public string tx_bytes;
            public BroadcastMode mode;
        }
        ///<summary>Broadcast a transaction to Aura LCD Endpoint. The transaction should be created and signed before sending; or otherwise, it will be rejected by the server. This function can be used for both SendTransaction and ExecuteContractTransaction</summary>
        /// <param name="signedTx">The Tx transaction that has gone through the creating and the signing process.</param>
        /// <returns>The HttpResponseMessage received from LCD after broadcastingTx.</returns>
        public static async Task<System.Net.Http.HttpResponseMessage> BroadcastTx(Tx signedTx){
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            ProtoBuf.Serializer.Serialize(memoryStream, signedTx);
            Logging.Verbose("Broadcasting transaction:", signedTx.SerializeToString());
            byte[] bytes = memoryStream.ToArray();
            Flurl.Http.IFlurlRequest flurlRequest = flurlClient.Request("cosmos", "tx", "v1beta1", "txs");
            LcdBroadcastedTx broadcastedTx = new LcdBroadcastedTx(){
                tx_bytes = System.Convert.ToBase64String(bytes),
                mode = BroadcastMode.BroadcastModeBlock
            };
            System.Net.Http.HttpResponseMessage httpResponseMessage = await flurlRequest.PostJsonAsync(
                new LcdBroadcastedTx(){
                    tx_bytes = System.Convert.ToBase64String(bytes),
                    mode = BroadcastMode.BroadcastModeBlock
                }
            );
            Logging.Info("response", await httpResponseMessage.Content.ReadAsStringAsync());
            return httpResponseMessage;
        }

        #region private
        private static MsgSend CreateSendMessage(string fromAddress, string toAddress, string denom, string amount){
            MsgSend msgSend = new MsgSend(){
                FromAddress = fromAddress,
                ToAddress = toAddress,
            };
            msgSend.Amounts.Add(new Coin() {
                Denom = denom,
                Amount = amount
            });
            return msgSend;
        }
        private static MsgExecuteContract CreateExecuteContractMessage(string senderAddress, string contractAddress, byte[] msgToSendToContract, string fundsDenom, string fundsAmount = null){
            MsgExecuteContract msgExecuteContract = new MsgExecuteContract() {
                Sender = senderAddress,
                Contract = contractAddress
            };

            if (fundsDenom != null && fundsAmount != null)
                msgExecuteContract.Funds.Add(new Coin() {
                    Denom = fundsDenom,
                    Amount = fundsAmount
                });

            msgExecuteContract.Msg = msgToSendToContract;
            return msgExecuteContract;
        }
        ///<summary> Create a fee in Constant.AURA_DENOM. Note that the fee is always in Constant.AURA_DENOM denom, defined in the Constant class </summary>
        private static Fee CreateFee(string payer, string granter, string amount){
            Fee fee = new Fee() {
                GasLimit = Constant.GAS_LIMIT,
                Payer = payer,
                Granter = granter
            };
            fee.Amounts.Add(new Coin() {
                Denom = Constant.AURA_DENOM,
                Amount = amount
            });
            return fee;
        }
        
        private static string GenerateRandomMemo(){
            return System.Guid.NewGuid().ToString("D");
        }
        #endregion
    }
}