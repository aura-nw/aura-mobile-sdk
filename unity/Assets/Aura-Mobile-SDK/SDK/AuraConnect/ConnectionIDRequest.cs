using SocketIOClient;
using System;
using System.Threading.Tasks;
using System.Threading;
using UnityEngine;
using System.Collections;
using System.Collections.Generic;

namespace AuraMobileSDK{
    public static partial class AuraConnect {
        const float CONNECTIONID_REQUEST_TIMEOUT = 20f;
        [Serializable]
        class ConnectionIDRequestParams{
            public string type;
            public class Message{
                public string url;
                public string id;
            }
            public Message message;
        }
        class ConnectionIDResponse{
            public readonly bool success;
            public readonly string connectionID;
            public ConnectionIDResponse(bool success, string connectionID){
                this.success = success;
                this.connectionID = connectionID;
            }
        }
        static Promise<string> RequestConnectionID(SocketIOUnity socket){
            ConnectionIDRequestParams requestParams = new ConnectionIDRequestParams {
                type = "connection_request",
                message = new ConnectionIDRequestParams.Message {
                    url = "app://open.my.app",
                    id = Guid.NewGuid().ToString()
                }
            };
            Promise<string> promise = new Promise<string>(CONNECTIONID_REQUEST_TIMEOUT, false, null);
            try{
                socket.EmitAsync("coin98_connect", (response)=>{
                    promise.Resolve(true, response.GetValue<string>());    
                }, requestParams).ConfigureAwait(true);
            } catch (Exception e){
                Logging.Error("Exception occurred when trying to get connectionID. Message:", e.Message, e.StackTrace);
                promise.Resolve(false, null);    
            }
            return promise;
        }
    }
}