using System;
namespace AuraMobileSDK{
    public static partial class AuraConnect{
        public static void Connect(string dAppName, string callbackURL, string logoLink, string chainID){
            Coin98SocketConnector.CreateSocketConnection().Then((success, socket) => {
                Logging.Verbose(success, socket);
                if (success){
                    RequestConnectionID(socket).Then((success, connectionID) => {
                        if (success){
                            RequestC98MobileAppAuthorization(connectionID, dAppName, callbackURL, logoLink, chainID);
                        } else {
                            
                        }
                    });
                } else {
                    
                }
            });
        }
    }
}