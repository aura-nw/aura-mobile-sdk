#define USE_NETWORK_EUPHORIA
using dotnetstandard_bip39;
namespace AuraSDK{
    public partial class Constant{
        public const int BIP39_STRENGTH = 256;
        public const BIP39Wordlist BIP39_WORDLIST = BIP39Wordlist.English;
        ///Cosmos Derivation path
        public const string DERIVATION_PATH = "m/44'/118'/0'/0/0";
        #if USE_NETWORK_SERENITY //testnet
            public const string LCD_URL = "https://lcd.serenity.aura.network";
            public const string RPC_URL = "http://rpc.serenity.aura.network";
            public const string AURA_DENOM = "uaura";
            public const string CHAIN_ID = "serenity-testnet-001";
        #elif USE_NETWORK_EUPHORIA //staging net
            public const string LCD_URL = "https://lcd.euphoria.aura.network";
            public const string RPC_URL = "http://rpc.euphoria.aura.network";
            public const string AURA_DENOM = "ueaura";
            public const string CHAIN_ID = "euphoria-2";
        #else //mainnet
            public const string LCD_URL = "https://lcd.aura.network";
            public const string RPC_URL = "http://rpc.aura.network";
            public const string AURA_DENOM = "uaura";
            public const string CHAIN_ID = "xstaxy-1";
        #endif
        public const string BECH32_HRP = "aura";
        public const string DEFAULT_FEE_AMOUNT = "200";
        public const ulong DEFAULT_GAS_LIMIT = 200000;

        // API Endpoint
        /// <summary>
        /// API_GET_BALANCE to use with string.Format function
        /// </summary>
        /// <param name="{0}">address: The address you want to query</param>
        /// <param name="{1}">denom: The denom on which you want to query</param>
        public const string API_GET_BALANCE = "/cosmos/bank/v1beta1/balances/{0}/by_denom?denom={1}";

        /// <summary>
        /// API_GET_ACCOUNT to use with string.Format function
        /// </summary>
        /// <param name="{0}">address: The address you want to query</param>
        public const string API_GET_ACCOUNT = "/cosmos/auth/v1beta1/accounts/{0}";

        /// <summary>
        /// API_QUERY_TX_DETAILS to use with string.Format function
        /// </summary>
        /// <param name="{0}">txhash: The txhash of the transaction you want to query</param>
        public const string API_QUERY_TX_DETAILS = "/cosmos/tx/v1beta1/txs/{0}";

        /// <summary>
        /// API_QUERY_SMART_CONTRACT to use with string.Format function
        /// </summary>
        /// <param name="{0}">contractAddress: The address of the contract you want to query status</param>
        /// <param name="{1}">queryBase64: The query json encoded in base64 format you want to send to the contract.</param>
        public const string API_QUERY_SMART_CONTRACT = "/cosmwasm/wasm/v1/contract/{0}/smart/{1}";

        public const string API_SIMULATE_TX = "/cosmos/tx/v1beta1/simulate";
        public const string API_BROADCAST_TX = "/cosmos/tx/v1beta1/txs";
    }
}
