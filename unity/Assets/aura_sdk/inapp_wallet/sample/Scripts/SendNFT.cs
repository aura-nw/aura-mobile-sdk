using UnityEngine;
using AuraSDK;
using cosmos.tx.v1beta1;

public class SendNFT : MonoBehaviour
{
    [SerializeField]
    TMPro.TMP_Text log;
    async void OnEnable()
    {
        log.text = "Sending nft token 2 to aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx";
        Tx tx = await DemoIAW.wallet.CreateExecuteContractTransaction(
            //contract address
            "aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx",
            //message
            "{\"transfer_nft\": {\"recipient\": \"aura1k24l7vcfz9e7p9ufhjs3tfnjxwu43h8quq4glv\",\"token_id\": \"2\"}}"
        );
        await DemoIAW.wallet.SignTransaction(tx);
        var result = await InAppWallet.BroadcastTx(tx);
        log.text += "\nResult: " + result.Content;
    }
}
