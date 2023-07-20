using System;
using Newtonsoft.Json;
using UnityEngine;
using System.Collections.Generic;
using System.Collections;
namespace AuraSDK{
    public static class URLOpener{
        ///implement URLOpener using a queue to force the launching job run on the main thread, avoiding the situation of app crash due to multithreaded activity incompatibility
        static Queue<string> urlsToLaunch = new Queue<string>();

        [RuntimeInitializeOnLoadMethod]
        static void InitializeURLOpener(){
            CoroutineRunner.StartCoroutine(LaunchURLInQueue());
        }
        static IEnumerator LaunchURLInQueue(){
            while(true){
                if (urlsToLaunch.Count > 0){
                    string url = urlsToLaunch.Dequeue();
                    Debug.Log("Launching " + url);
                    #if UNITY_ANDROID
                        //AndroidJNI.AttachCurrentThread();
                        AndroidJavaClass androidJC = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
                        AndroidJavaObject jo= androidJC.GetStatic<AndroidJavaObject>("currentActivity");
                        jo.Call("OpenURL", url);
                        Logging.Verbose("Launched");
                        //AndroidJNI.DetachCurrentThread();
                    #else
                        Application.OpenURL(url);
                    #endif
                }
                yield return null;
            }
        }
        public static void Open(string url){
            urlsToLaunch.Enqueue(url);
            Debug.Log("Queued " + url);
        }
    }
}