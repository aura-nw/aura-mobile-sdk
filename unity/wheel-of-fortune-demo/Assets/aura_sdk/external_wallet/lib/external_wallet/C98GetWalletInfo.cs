using System;
using Newtonsoft.Json;
using UnityEngine;
namespace AuraSDK{
    public partial class ExternalWallet{
        [Serializable]
        class C98GetWalletInfoRequest{
            public string method;
            [JsonProperty(PropertyName = "params")]
            public string[] param_array; //to avoid matching c# keyword params
            public string id;
            public string chain;
            public string redirect;
        }
        void RequestC98WalletInfo(string connectionID, string dAppName, string callbackURL, string logoLink, string chainID){
            C98GetWalletInfoRequest authorizationRequest = new C98GetWalletInfoRequest {
                id = GenerateAuthorizationRequestUniqueID(),
                method = "cosmos_getKey",
                param_array = new string[]{
                    chainID
                },
                redirect = callbackURL,
                chain = chainID
            };
            Logging.Verbose(JsonConvert.SerializeObject(authorizationRequest));
            string deeplink = $"{connectionID}&request={Uri.EscapeDataString(JsonConvert.SerializeObject(authorizationRequest))}";
            deeplink = @"coin98://" + Uri.EscapeDataString(deeplink);
            Logging.Verbose(deeplink);
            URLOpener.Open(deeplink);
        }
    }
}