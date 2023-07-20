using System.Numerics;
using UnityEngine;
public class WoFConfig{
    public static BigInteger WHEEL_SPINNING_FEE = 1000;
    public static BigInteger CONTRACT_SENDING_FEE = 200;
    [RuntimeInitializeOnLoadMethod]
    static void ConfigureTargetFramerate(){
        Application.targetFrameRate = 90;
    }
}