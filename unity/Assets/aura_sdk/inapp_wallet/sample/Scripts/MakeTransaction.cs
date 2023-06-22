using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System.Numerics;

public class MakeTransaction : MonoBehaviour
{
    [SerializeField]
    TMP_Text info;
    [SerializeField]
    TMP_InputField toAddress, amount;
    [SerializeField]
    Button send;
    // Start is called before the first frame update
    async void OnEnable()
    {
        BigInteger balance = await DemoIAW.wallet.CheckBalance(AuraSDK.Constant.AURA_DENOM);
        info.text = "From address: " + DemoIAW.wallet.address + "\n" + "Balance: " + balance.ToString();
        send.onClick.AddListener(async () => {
            var tx = await DemoIAW.wallet.CreateSendTransaction(toAddress.text, AuraSDK.Constant.AURA_DENOM, amount.text);
            await DemoIAW.wallet.SignTransaction(tx);
            var broadcastResponse = await AuraSDK.InAppWallet.BroadcastTx(tx);
            Logging.Verbose(broadcastResponse.StatusCode, broadcastResponse.Content);
            //go back to main menu
            DemoIAW.instance.currentScreen = DemoIAW.Screen.MAIN_MENU;
        });
    }
}
