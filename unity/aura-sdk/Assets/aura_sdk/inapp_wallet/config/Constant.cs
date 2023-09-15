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
    }
}