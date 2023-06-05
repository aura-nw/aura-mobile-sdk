using UnityEngine;
using System.Threading;
namespace AuraSDK{
    public static class ThreadChecker{
        static Thread mainThread;
        [RuntimeInitializeOnLoadMethod]
        static void InitializeThreadChecker(){
            mainThread = Thread.CurrentThread;
        }
        public static bool IsThisOnTheMainThread(){
            return Thread.CurrentThread == mainThread;
        }
    }
}