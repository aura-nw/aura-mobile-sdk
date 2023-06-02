using System.Collections.Generic;
using UnityEngine;
using AuraSDK;

public class TransactionHistory : MonoBehaviour
{
    [SerializeField]
    TMPro.TMP_Text log;
    async void OnEnable()
    {
        log.text = "";
        List<AuraTransaction> transactionHistory = await DemoIAW.wallet.CheckWalletHistory();
        foreach(AuraTransaction transaction in transactionHistory){
            log.text += $"{transaction.type}: {transaction.fromAddress.Substring(32)} -> {transaction.toAddress.Substring(32)} {transaction.amount} uaura\n";
        }
    }
}
