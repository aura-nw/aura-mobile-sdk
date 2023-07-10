using UnityEngine;
using AuraSDK;
using cosmos.tx.v1beta1;

public class SendNFT : MonoBehaviour
{
    [SerializeField]
    TMPro.TMP_Text log;
    async void OnEnable()
    {
        log.text = "Querying reward from aura158kn7jhsvttsmhn4q9jf2mteu5nsq8e6lxrfgmnhzg55ghftfh6qngxk6g";
        var wheel_rewards_response = await InAppWallet.QuerySmartContract(
            contractAddress: "aura158kn7jhsvttsmhn4q9jf2mteu5nsq8e6lxrfgmnhzg55ghftfh6qngxk6g",
            queryJson: "{\"get_wheel_rewards\":{}}");
        log.text += wheel_rewards_response.StatusCode + " " + wheel_rewards_response.Content;
        Logging.Verbose(wheel_rewards_response.StatusCode + " " + wheel_rewards_response.Content);

        log.text += "Sending nft token 2 to aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx";
        Tx tx = await DemoIAW.wallet.CreateExecuteContractTransaction(
            //contract address
            "aura1qye5hls3tnttxfhaa2klftrqcevcz02a4uzzy568nm5cgkqfvflqpu7plx",
            //message
            "{\"transfer_nft\": {\"recipient\": \"aura1k24l7vcfz9e7p9ufhjs3tfnjxwu43h8quq4glv\",\"token_id\": \"2\"}}"
        );
        await DemoIAW.wallet.SignTransaction(tx);
        var sendNFT_response = await InAppWallet.BroadcastTx(tx);
        log.text += "\nResult: " + sendNFT_response.Content;
        Logging.Verbose(sendNFT_response.Content);
    }
}
