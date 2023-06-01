using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AuraSDK;

public class CheckBalance : MonoBehaviour
{
    [SerializeField]
    TMPro.TMP_Text output;
    async void OnEnable()
    {
        if (DemoIAW.wallet != null){
            output.text = "Checking account balance...";
            output.text = "Account address: " + DemoIAW.wallet.address + "\nBalance: " + await DemoIAW.wallet.CheckBalance() + " uaura";
        } else {
            output.text = "Please restore or create a wallet first";
        }
    }
}
