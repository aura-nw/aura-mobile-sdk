using UnityEngine;
using TMPro;
using UnityEngine.UI;
using System.Numerics;
using Newtonsoft.Json.Linq;
public class MakeTransaction : MonoBehaviour
{
    [SerializeField]
    TMP_Text info;
    [SerializeField]
    TMP_InputField toAddress, amount;
    [SerializeField]
    Button simulate, send;
    async void OnEnable(){
        var balanceCheckResult = await DemoIAW.wallet.CheckBalance(AuraSDK.Constant.AURA_DENOM);
        if (balanceCheckResult.success)
            info.text = "From address: " + DemoIAW.wallet.address + "\n" + "Balance: " + balanceCheckResult.balance.ToString();
        else 
            info.text = "From address: " + DemoIAW.wallet.address + "\n" + "Balance: query error";
    }

    // Start is called before the first frame update
    async void Start()
    {
        simulate.onClick.AddListener(async () => {
            var tx = await DemoIAW.wallet.CreateSendTransaction(toAddress.text, AuraSDK.Constant.AURA_DENOM, amount.text);
            await DemoIAW.wallet.SignTransaction(tx);

            var simulateResponse = await AuraSDK.InAppWallet.SimulateTx(tx);
            Logging.Verbose(simulateResponse.StatusCode, simulateResponse.Content);

            if (simulateResponse.StatusCode == 200){
                JObject resObj = JObject.Parse(simulateResponse.Content);
                Logging.Info("Gas Used in simulation:", resObj["gas_info"]["gas_used"].ToString());
            }
        });

        send.onClick.AddListener(async () => {
            var tx = await DemoIAW.wallet.CreateSendTransaction(toAddress.text, AuraSDK.Constant.AURA_DENOM, amount.text);
            await DemoIAW.wallet.SignTransaction(tx);

            var broadcastResponse = await AuraSDK.InAppWallet.BroadcastTx(tx);
            Logging.Verbose(broadcastResponse.StatusCode, broadcastResponse.Content);

            if (broadcastResponse.StatusCode == 200){
                JObject resObj = JObject.Parse(broadcastResponse.Content);
                string txhash = resObj["tx_response"]["txhash"].ToString();

                while (true) {
                    // Check if the transaction is completed or not
                    var txCheckResponse = await AuraSDK.InAppWallet.QueryTransactionDetails(txhash);
                    Logging.Verbose(txCheckResponse.StatusCode, txCheckResponse.Content);

                    if (txCheckResponse.StatusCode == 200){
                        JObject txDetails = JObject.Parse(txCheckResponse.Content);

                        ulong height;
                        if (ulong.TryParse(txDetails["tx_response"]["height"].ToString(), out height) && height > 0){
                            //transaction included in some block

                            ulong code;
                            if (ulong.TryParse(txDetails["tx_response"]["code"].ToString(), out code) && code > 0){
                                Logging.Error("Transaction failed. Code =", code);
                                break;
                            } else {
                                Logging.Info("Transaction successful. Height =", height);
                                break;
                            }
                        }
                    } 
                    
                    Logging.Info("Transaction incomplete. Recheck the transaction details in 5 seconds...");
                    // delay for 5 seconds before making the next call
                    await System.Threading.Tasks.Task.Delay(5000);
                }
            } else {
                Logging.Error("Can't broadcast transaction", broadcastResponse.StatusCode, broadcastResponse.Content);
            }
            //go back to main menu
            DemoIAW.instance.currentScreen = DemoIAW.Screen.MAIN_MENU;
        });
    }
}
