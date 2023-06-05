using dotnetstandard_bip39;
namespace AuraSDK{
    public partial class Constant{
        public const int BIP39_STRENGTH = 256;
        public const BIP39Wordlist BIP39_WORDLIST = BIP39Wordlist.English;
        ///Cosmos Derivation path
        public const string DERIVATION_PATH = "m/44'/118'/0'/0/0";
        public const string LCD_URL = "https://lcd.serenity.aura.network";
        public const string RPC_URL = "http://rpc.serenity.aura.network";
        public const string BECH32_HRP = "aura";
        public const string FEE_DENOM = "uaura";
        public const ulong GAS_LIMIT = 200000;
        public const string CHAIN_ID = "serenity-testnet-001";
    }
}