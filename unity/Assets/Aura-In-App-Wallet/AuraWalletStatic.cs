using dotnetstandard_bip39;
using dotnetstandard_bip32;
using cosmos.tx.v1beta1;
using cosmos._base.v1beta1;
using cosmos.bank.v1beta1;
using cosmos.tx.signing.v1beta1;
using System.Security.Cryptography;
using System.Threading.Tasks;
using CosmosApi;
using Flurl.Http;

namespace AuraMobileSDK{
    public partial class AuraWallet{
        private static readonly ICosmosApiClient cosmosApiClient;
        private static readonly Flurl.Http.FlurlClient flurlClient;
        static AuraWallet(){
            cosmosApiClient = new CosmosApiBuilder()
                .UseBaseUrl(Constant.LCD_URL)
                .RegisterCosmosSdkTypeConverters()
                .RegisterAccountType<CosmosApi.Models.BaseAccount>("cosmos-sdk/BaseAccount")
                .CreateClient();
             
            flurlClient = new Flurl.Http.FlurlClient(Constant.LCD_URL);
        }
        public static AuraWallet CreateRandomHDWallet(){
            BIP39 bIP39 = new BIP39();
            return new AuraWallet(bIP39.GenerateMnemonic(Constant.BIP39_STRENGTH, Constant.BIP39_WORDLIST));
        }
        public static AuraWallet RestoreAuraWallet(string mnemonic, string password = ""){
            return new AuraWallet(mnemonic, password);
        }
        public static bool CheckMnemonic(string mnemonic){
            BIP39 bIP39 = new BIP39();
            return bIP39.ValidateMnemonic(mnemonic, Constant.BIP39_WORDLIST);
        }
        private static MsgSend CreateSendMessage(string fromAddress, string toAddress, string amount){
            MsgSend msgSend = new MsgSend(){
                FromAddress = fromAddress,
                ToAddress = toAddress,
            };
            msgSend.Amounts.Add(new Coin() {
                Denom = Constant.DENOM,
                Amount = amount
            });
            return msgSend;
        }
        private static Fee CreateFee(string payer, string granter, string amount){
            Fee fee = new Fee() {
                GasLimit = Constant.GAS_LIMIT,
                Payer = payer,
                Granter = granter
            };
            fee.Amounts.Add(new Coin() {
                Denom = Constant.DENOM,
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
        private static async Task BroadcastTx(Tx signedTx){
            // Logging.Verbose(System.Text.Encoding.ASCII.GetString(Google.Protobuf.WellKnownTypes.Any.Pack(signedTx.Body).Value));
            // Logging.Verbose(System.Text.Encoding.ASCII.GetString(Google.Protobuf.WellKnownTypes.Any.Pack(signedTx.AuthInfo).Value));
            // Logging.Verbose(System.Text.Encoding.ASCII.GetString(Google.Protobuf.WellKnownTypes.Any.Pack(signedTx.Signatures).Value));
            // Logging.Verbose(System.Text.Encoding.ASCII.GetString(Google.Protobuf.WellKnownTypes.Any.Pack(signedTx, "/cosmos.tx.v1beta1.Tx").Value));
            System.IO.MemoryStream memoryStream = new System.IO.MemoryStream();
            // System.IO.StringWriter sW = new System.IO.StringWriter();
            // Newtonsoft.Json.JsonSerializer.Create().Serialize(sW, signedTx);
            // Logging.Verbose("In package", sW.ToString());
            ProtoBuf.Serializer.Serialize(memoryStream, signedTx);
            // Logging.Verbose(memoryStream.ToArray());
            // Logging.Verbose(System.Text.Encoding.ASCII.GetString(memoryStream.ToArray()));
            byte[] bytes = memoryStream.ToArray();
            Flurl.Http.IFlurlRequest flurlRequest = flurlClient.Request("cosmos", "tx", "v1beta1", "txs");
            System.Net.Http.HttpResponseMessage httpResponseMessage = await flurlRequest.PostJsonAsync(
                new LcdBroadcastedTx(){
                    tx_bytes = System.Convert.ToBase64String(bytes),
                    mode = BroadcastMode.BroadcastModeBlock
                }
            );
            // Logging.Info("response", httpResponseMessage);
        }
    }
}