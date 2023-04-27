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
    public class Coin98SocketConnector
    {
        const string SERVER_URI = "https://socket.coin98.services/";
        const float CONNECTION_TIMEOUT = 20f; //in seconds
        public static Promise<SocketIOUnity> CreateSocketConnection(){
            //initialize the options
            SocketIOOptions options = new SocketIOOptions{
                Transport = SocketIOClient.Transport.TransportProtocol.WebSocket,
                Reconnection = true,
                AutoUpgrade = true,
                ConnectionTimeout = TimeSpan.FromSeconds(CONNECTION_TIMEOUT)
            };
            
            //return promise
            Promise<SocketIOUnity> promise = new Promise<SocketIOUnity>();

            //initialize the socket
            SocketIOUnity socket = new SocketIOUnity(SERVER_URI, options);

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
            //connect the socket to the server
            socket.Connect();

            //Wait for the socket to be connected
            CoroutineRunner.WaitFor(
                condition: () => {return socket.Connected;}, action: () => promise.Resolve(true, socket), 
                maxWaitUnscaledTime: CONNECTION_TIMEOUT, onTimeout: () => promise.Resolve(false, null)
            );

            return promise;
        }
    }
}