using System;
namespace AuraSDK{
    public partial class ExternalWallet{
        string connectionID = null;
        public void RequestAuthorization(string dAppName, string callbackURL, string logoLink, string chainID){
            GetSocket().Then((success, socket) => {
                if (success){
                    Logging.Verbose("Requesting connectionID");
                    RequestConnectionID(socket).Then((success, _connectionID) => {
                        connectionID = _connectionID;
                        Logging.Verbose("Got ConnectionID:", _connectionID);
                        if (success){
                            /*socket.OnUnityThread("sdk_connect", (response) => {
                                Logging.Verbose(response);
                            });*/
                            RequestC98MobileAppAuthorization(_connectionID, dAppName, callbackURL, logoLink, chainID);
                        } else {
                            
                        }
                    });
                } else {
                    
                }
            });
        }
        public void GetWalletInfo(string dAppName, string callbackURL, string logoLink, string chainID){
            GetSocket().Then((success, socket) => {
                if (success){
                    RequestC98WalletInfo(connectionID, dAppName, callbackURL, logoLink, chainID);
                }
            });
        }
    }
}