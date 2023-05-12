using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AuraMobileSDK{
    public static class PromiseMainThreadCaller{
        static Queue<Action> actions = new Queue<Action>();
        [RuntimeInitializeOnLoadMethod]
        static void Initialize(){
            CoroutineRunner.StartCoroutine(InvokeQueuedActions());
        }
        static IEnumerator InvokeQueuedActions(){
            while (true){
                while (actions.Count > 0){
                    Action action = actions.Dequeue();
                    action?.Invoke();
                }
                yield return null;
            }
        }
        public static void InvokeOnMainThread(Action action){
            actions.Enqueue(action);
        }
    }
    public class Promise{
        bool resultResolved = false, afterDefined = false, fulfilled = false;
        Action<bool> after;
        bool success;
        public Promise(float timeout, bool timeoutSuccessValue){
            CoroutineRunner.WaitFor(timeout, () => Resolve(timeoutSuccessValue));
        }
        public Promise(){
            //This promise will never time out and will run until a result is properly resolved
        }
        void TryInvoke(){
            if (!fulfilled && resultResolved && afterDefined){
                fulfilled = true;
                PromiseMainThreadCaller.InvokeOnMainThread(() => after?.Invoke(success));
            } 
        }
        public void Resolve(bool success){
            if (!fulfilled && !resultResolved){
                resultResolved = true;
                this.success = success;
                TryInvoke();
            }
        }
        public void Then(Action<bool> action){
            if (!fulfilled && !afterDefined){
                afterDefined = true;
                this.after = action;
                TryInvoke();
            }
        }
    }
    public class Promise<T> {
        bool resultResolved = false, afterDefined = false, fulfilled = false;
        Action<bool, T> after;
        T result;
        bool success;
        public Promise(float timeout, bool timeoutSuccessValue, T timeoutResult){
            CoroutineRunner.WaitFor(timeout, () => Resolve(timeoutSuccessValue, timeoutResult));
        }
        public Promise(){
            //This promise will never time out and will run until a result is properly resolved
        }
        void TryInvoke(){
            if (!fulfilled && resultResolved && afterDefined){
                fulfilled = true;
                PromiseMainThreadCaller.InvokeOnMainThread(() => after?.Invoke(success, result));
            } 
        }
        public void Resolve(bool success, T result){
            if (!fulfilled && !resultResolved){
                resultResolved = true;
                this.result = result;
                this.success = success;
                TryInvoke();
            }
        }
        public void Then(Action<bool, T> action){
            if (!fulfilled && !afterDefined){
                afterDefined = true;
                this.after = action;
                TryInvoke();
            }
        }
    }
}