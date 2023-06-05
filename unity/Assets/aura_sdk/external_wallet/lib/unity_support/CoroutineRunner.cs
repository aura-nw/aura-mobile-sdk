using System.Collections.Generic;
using UnityEngine;
using System;
using System.Collections;

namespace AuraSDK{
    public static class CoroutineRunner {
        public class Runner : MonoBehaviour{
            public delegate bool ConditionTestFunction();
            public IEnumerator WaitFor(ConditionTestFunction condition, Action action, float maxWaitUnscaledTime, Action onTimeout) {
                if (action == null) {
                    yield break;
                }
                while (true) {
                    if (condition() == true) {
                        action?.Invoke();
                        yield break;
                    }
                    else
                    {
                        //check if there's still time for waiting
                        if (maxWaitUnscaledTime > 0)
                        {
                            //now we wait one frame
                            yield return null;
                            
                            //after waiting, update the wait limits
                            maxWaitUnscaledTime -= Time.unscaledDeltaTime;
                        } 
                        else //can't wait anymore
                        {
                            onTimeout?.Invoke();
                            yield break;
                        }
                    }
                }
            }
            public IEnumerator WaitFor(float waitTime, Action action)
            {
                if (waitTime > 0)
                    yield return new WaitForSecondsRealtime(waitTime);
                action?.Invoke();
            }
        }
        static Runner instance;
        static Runner GetInstance(bool createIfNull = true){
            try{
                if (createIfNull && (instance == null || instance.gameObject == null || instance.gameObject.transform == null)){
                    GameObject g = new GameObject("CoroutineRunner");
                    GameObject.DontDestroyOnLoad(g);
                    instance = g.AddComponent<Runner>();
                }
            } catch (Exception e){
                Logging.Verbose(e.Message, e.StackTrace);
            }
            return instance;
        }

        ///<summary>StartCoroutine using Runner's auto-generated instance.</summary>
        public static Coroutine StartCoroutine(IEnumerator ie){
            Runner instance = GetInstance();
            if (instance == null) return null;
            return instance.StartCoroutine(ie);
        }
        ///<summary>StopCoroutine using Runner's auto-generated instance</summary>
        public static void StopCoroutine(Coroutine coroutine){
            GetInstance(false)?.StopCoroutine(coroutine);
        }
        ///<summary>Wait for a condition and run</summary>
        public static void WaitFor(Runner.ConditionTestFunction condition, Action action, float maxWaitUnscaledTime, Action onTimeout){
            Runner instance = GetInstance(true);
            instance.StartCoroutine(instance.WaitFor(condition, action, maxWaitUnscaledTime, onTimeout));
        }
        ///<summary>Wait for a period of time and run</summary>
        public static void WaitFor(float waitTime, Action action){
            Runner instance = GetInstance(true);
            instance.StartCoroutine(instance.WaitFor(waitTime, action));
        }
    }
}