using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using System;

public class Logging : MonoBehaviour{
    static string ObjectToString(object x){
        if (x == null) return "null";
        if (!(x is string)){
            if (x is IEnumerable){
                StringBuilder stringBuilder = new StringBuilder();
                bool first = true;
                if (x is ISet<object> || x is IDictionary<object, object>) stringBuilder.Append('{');
                else stringBuilder.Append('[');
                foreach (var t in x as IEnumerable){
                    if (!first)
                        stringBuilder.Append(", ");
                    first = false;
                    stringBuilder.Append(ObjectToString(t));
                }
                if (x is ISet<object> || x is IDictionary<object, object>) stringBuilder.Append('}');
                else stringBuilder.Append(']');
                return stringBuilder.ToString();
            } else return x.ToString();
        } else return (string) x;
    }
    const string DEBUG_TAG = "AuraSDK: ";
    static string ParamsToString(object[] x){
        if (x == null) return "null";
        if (x.Length == 0) return "";
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.Append(DEBUG_TAG);
        stringBuilder.Append(ObjectToString(x[0]));
        for (int i = 1; i < x.Length; ++i){
            stringBuilder.Append(' ');
            stringBuilder.Append(ObjectToString(x[i]));
        }
        return stringBuilder.ToString();
    }
    public static void Verbose(params object[] x){
        Debug.Log(ParamsToString(x));
    }
    public static void Info(params object[] x){
        Debug.Log(ParamsToString(x));
    }
    public static void Error(params object[] x){
        Debug.LogError(ParamsToString(x));
    }
    public static void Warning(params object[] x){
        Debug.LogWarning(ParamsToString(x));
    }
}