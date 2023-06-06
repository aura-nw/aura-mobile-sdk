using UnityEngine;

public class CheckBalance : MonoBehaviour
{
    [SerializeField]
    TMPro.TMP_Text output;
    async void OnEnable()
    {
        if (DemoIAW.wallet != null){
            output.text = "Checking account balance...";
            output.text = "Account address: " + DemoIAW.wallet.address + "\nBalance: " + await DemoIAW.wallet.CheckBalance(AuraSDK.Constant.AURA_DENOM) + $" {AuraSDK.Constant.AURA_DENOM}";
        } else {
            output.text = "Please restore or create a wallet first";
        }
    }
}
