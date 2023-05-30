using System;
using System.Collections.Generic;
using SocketIOClient;
using SocketIOClient.Newtonsoft.Json;
using UnityEngine;
using UnityEngine.UI;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Threading;
using System.Threading.Tasks;

namespace AuraMobileSDK{
    public partial class AuraConnect
    {
        SocketIOUnity socket = null;
        public Promise<SocketIOUnity> GetSocket(){
            //return promise
            Promise<SocketIOUnity> promise = new Promise<SocketIOUnity>();
            if (socket != null){
                //Wait for the socket to be connected
                CoroutineRunner.WaitFor(
                    condition: () => {return socket.Connected;}, action: () => promise.Resolve(true, socket), 
                    maxWaitUnscaledTime: Constant.SOCKET_CONNECTION_TIMEOUT, onTimeout: () => {
                        promise.Resolve(false, null);
                        socket = null;
                    }
                );
            } else {
                //initialize the options
                SocketIOOptions options = new SocketIOOptions{
                    Transport = SocketIOClient.Transport.TransportProtocol.WebSocket,
                    Reconnection = true,
                    AutoUpgrade = true,
                    ConnectionTimeout = TimeSpan.FromSeconds(Constant.SOCKET_CONNECTION_TIMEOUT)
                };
                
                //initialize the socket
                socket = new SocketIOUnity(Constant.SERVER_URI, options);

                //set newtonsoft as the default json serializer of the socket
                socket.JsonSerializer = new NewtonsoftJsonSerializer();

                ///// reserved socketio events
                socket.OnConnected += (sender, e) =>
                {
                    Logging.Verbose("socket.OnConnected");
                };
                socket.OnPing += (sender, e) =>
                {
                    Logging.Verbose("Ping");
                };
                socket.OnPong += (sender, e) =>
                {
                    Logging.Verbose("Pong: " + e.TotalMilliseconds);
                };
                socket.OnDisconnected += (sender, e) =>
                {
                    Logging.Verbose("disconnect: " + e);
                };
                socket.OnReconnectAttempt += (sender, e) =>
                {
                    Logging.Verbose($"{DateTime.Now} Reconnecting: attempt = {e}");
                };
                ////

                //listen to response
                socket.OnAnyInUnityThread((eventName, response) => {
                    Logging.Verbose("OnAny:", eventName, response);
                });
                socket.OnAny((eventName, response) => {
                    Logging.Verbose("OnAny:", eventName, response);
                });
                socket.OnUnityThread("coin98_connect", (data) => {
                    Logging.Verbose("OnAny:", data);
                });
                socket.OnError += (sender, errorString) => {
                    Logging.Verbose("Error", sender, errorString);
                };
                Logging.Verbose("Connecting to socket", options.ToString(), socket);
                //connect the socket to the server
                socket.Connect();

                //Wait for the socket to be connected
                CoroutineRunner.WaitFor(
                    condition: () => {return socket.Connected;}, action: () => promise.Resolve(true, socket), 
                    maxWaitUnscaledTime: Constant.SOCKET_CONNECTION_TIMEOUT, onTimeout: () => {
                        promise.Resolve(false, null);
                        socket = null;
                    }
                );
            }
            return promise;
        }
    }
}