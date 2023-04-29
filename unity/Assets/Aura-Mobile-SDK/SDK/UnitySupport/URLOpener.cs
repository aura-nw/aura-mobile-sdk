using System;
using Newtonsoft.Json;
using UnityEngine;
namespace AuraMobileSDK{
    public static class URLOpener{
        public static void Open(string url){
            #if UNITY_ANDROID
                AndroidJavaClass androidJC = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
                AndroidJavaObject jo= androidJC.GetStatic<AndroidJavaObject>("currentActivity");
                jo.Call("OpenURL", url);
                Logging.Verbose("Launched");
            #else
                Application.OpenURL(deeplink);
            #endif
        }
    }
}