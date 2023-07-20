using UnityAdvancedPlayerPrefs;
using System.Collections.Generic;
using System.Linq;
namespace AuraSDK{
    public static class InAppWalletManager{
        public const string PREF_PREFIX = "AuraSDK.InAppWalletManager";
        public static bool initialized {get; private set;} = false;
        static AdvancedPlayerPrefs prefs;
        static Dictionary<string, InAppWallet> wallets = new Dictionary<string, InAppWallet>();
        static bool SaveWalletsToPrefs(){
            if (!initialized || wallets == null) throw new System.Exception("InAppWalletManager has not been initialized or has been incorrectly initialized.");
            prefs.SetInt("walletCount", wallets.Count);
            int index = 0;
            foreach (var wallet in wallets.Values)
                prefs.SetString($"walletMnemonic_{index++}", wallet.mnemonic);
            return true;
        }
        public static bool Initialize(string password){
            if (initialized) {
                throw new System.Exception("InAppWalletManager can only be initialized once. To change your password, call ChangePassword.");
            }
            prefs = new AdvancedPlayerPrefs(PREF_PREFIX, password);
            
            // load wallets from prefs
            List<string> mnemonics = new List<string>();
            int walletCount = prefs.GetInt("walletCount", -1);
            if (walletCount < 0) return false;
            else {
                for (int i = 0; i < walletCount; ++i){
                    string mnemonic = prefs.GetString($"walletMnemonic_{i}", "not valid");
                    if (string.IsNullOrWhiteSpace(mnemonic) || !InAppWallet.CheckMnemonic(mnemonic)){
                        return false;
                    }
                    mnemonics.Add(mnemonic);
                }
                wallets.Clear();
                foreach (string mnemonic in mnemonics){
                    InAppWallet wallet = new InAppWallet(mnemonic);
                    wallets.Add(wallet.address, wallet);
                }
                initialized = true;
                return true;
            }
        }
        public static bool ChangePassword(string newPassword){
            if (!initialized) {
                throw new System.Exception("InAppWalletManager has not been initialized.");
            }
            prefs = new AdvancedPlayerPrefs(PREF_PREFIX, newPassword);
            return SaveWalletsToPrefs();
        }
        public static bool AddWallet(InAppWallet wallet){
            if (!initialized) {
                throw new System.Exception("InAppWalletManager has not been initialized.");
            }
            wallets.Add(wallet.address, wallet);
            return SaveWalletsToPrefs();
        }
        public static bool RemoveWallet(string address){
            if (!initialized) {
                throw new System.Exception("InAppWalletManager has not been initialized.");
            }
            if (wallets.ContainsKey(address)){
                wallets.Remove(address);
                return SaveWalletsToPrefs();
            } 
            return false;
        }
        public static string[] GetWalletAddresses(){
            if (!initialized) {
                throw new System.Exception("InAppWalletManager has not been initialized.");
            }
            return wallets.Keys.ToArray();
        }
        public static InAppWallet GetWalletByAddress(string address){
            if (!initialized) {
                throw new System.Exception("InAppWalletManager has not been initialized.");
            }
            if (wallets.ContainsKey(address)) return wallets[address];
            else return null;
        }
    }
}