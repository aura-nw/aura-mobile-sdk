using System;
namespace AuraMobileSDK{
    public partial class AuraConnect{
        string connectionID = null;
        public void RequestAuthorization(string dAppName, string callbackURL, string logoLink, string chainID){
            GetSocket().Then((success, socket) => {
                Logging.Verbose(success, "Requesting connectionID");
                if (success){
                    RequestConnectionID(socket).Then((success, _connectionID) => {
                        connectionID = _connectionID;
                        Logging.Verbose(success, _connectionID);
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