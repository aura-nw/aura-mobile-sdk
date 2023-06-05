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
        ///<summary>Create a random HD Wallet using default strength as <paramref name="Constant.BIP39_STRENGTH"> and default wordlist as <paramref name="Constant.BIP39_WORDLIST"></summary>
        public static InAppWallet CreateRandomHDWallet(string password = ""){
            BIP39 bIP39 = new BIP39();
            return new InAppWallet(bIP39.GenerateMnemonic(Constant.BIP39_STRENGTH, Constant.BIP39_WORDLIST), password);
        }
        ///<summary>Restore HD Wallet using mnemonic phrase and a password (if you have one; otherwise, empty string "" will be used as password). It is the same as calling the InAppWallet constructor</summary>
        public static InAppWallet RestoreHDWallet(string mnemonic, string password = ""){
            return new InAppWallet(mnemonic, password);
        }
        ///<summary>Check if the mnemonic is a valid BIP39 mnemonic in <paramref name="Constant.BIP39_WORDLIST"> wordlist</summary>
        public static bool CheckMnemonic(string mnemonic){
            BIP39 bIP39 = new BIP39();
            return bIP39.ValidateMnemonic(mnemonic, Constant.BIP39_WORDLIST);
        }
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

            if (fundsAmount != null)
                msgExecuteContract.Funds.Add(new Coin() {
                    Denom = fundsDenom,
                    Amount = fundsAmount
                });

            msgExecuteContract.Msg = msgToSendToContract;
            return msgExecuteContract;
        }
        ///<summary> Create a fee in uaura. Note that the fee is always in uaura denom, defined in the Constant class </summary>
        private static Fee CreateFee(string payer, string granter, string amount){
            Fee fee = new Fee() {
                GasLimit = Constant.GAS_LIMIT,
                Payer = payer,
                Granter = granter
            };
            fee.Amounts.Add(new Coin() {
                Denom = Constant.FEE_DENOM,
                Amount = amount
            });
            return fee;
        }
        
        private static string GenerateRandomMemo(){
            return System.Guid.NewGuid().ToString("D");
        }
        [System.Serializable]
        class LcdBroadcastedTx{
            public string tx_bytes;
            public BroadcastMode mode;
        }
        ///<summary>Broadcast a transaction to Aura LCD Endpoint. The transaction should be created and signed before sending; or otherwise, it will be rejected by the server</summary>
        public static async Task<System.Net.Http.HttpResponseMessage> BroadcastTx(Tx signedTx){
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            ProtoBuf.Serializer.Serialize(memoryStream, signedTx);
            byte[] bytes = memoryStream.ToArray();
            Flurl.Http.IFlurlRequest flurlRequest = flurlClient.Request("cosmos", "tx", "v1beta1", "txs");
            System.Net.Http.HttpResponseMessage httpResponseMessage = await flurlRequest.PostJsonAsync(
                new LcdBroadcastedTx(){
                    tx_bytes = System.Convert.ToBase64String(bytes),
                    mode = BroadcastMode.BroadcastModeBlock
                }
            );
            Logging.Info("response", await httpResponseMessage.Content.ReadAsStringAsync());
            return httpResponseMessage;
        }
    }
}