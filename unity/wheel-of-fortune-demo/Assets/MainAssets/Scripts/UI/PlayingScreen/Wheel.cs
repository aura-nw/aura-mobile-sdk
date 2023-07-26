using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EasyUI.PickerWheelUI;
using Michsky.MUIP;
using System.Threading.Tasks;
using TUtils;
using AuraSDK;
using UnityEngine.UI;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
public class Wheel : MonoBehaviour
{
    public const string woFContractAddress = "aura1upyv5y5ak7ewelak2tptdjuku25jljky4j76nscatf0ssw8n3ufqlmenr3"; //EUPHORIA
    // public const string woFContractAddress = "aura1pzr4c8lcc9e8kzry5qykjsfy7s8t969c6au5k563ev6gd8tx4rpsus9q8g"; //SERENITY
    public bool IsSpinning{
        get{
            return pickerWheel.IsSpinning;
        }
    }
    [SerializeField]
    PickerWheel pickerWheel;    
    [SerializeField]
    Button spinningButton;
    [SerializeField]
    GameObject spinningText, backButton; //to disable backButton when spinning
    [SerializeField]
    TMPro.TMP_Text txHashText;
    string txHash;
    void CopyTxHash(){
        GUIUtility.systemCopyBuffer = txHash;
    }
    void UpdateTxHash(string txHash){
        this.txHash = txHash;
        if (!string.IsNullOrWhiteSpace(txHash))
            txHashText.text = $"Tap to copy your txHash\n{txHash}";
        else txHashText.text = "";
    }
    bool wheelLoaded = false;
    void Start()
    {
        spinningButton.onClick.AddListener(() => {
            RequestSpin();
        });
        pickerWheel.OnSpinEnd((piece) => {
            Tebug.Log("Spinning finished");
            ShowReadyUI();
            Popup.instance.ShowPopup("Reward arrived", $"You have got {piece.Label}");
        });
        spinningText.SetActive(false);
        txHashText.GetComponent<Button>()?.onClick.AddListener(CopyTxHash);
    }
    async void OnEnable(){
        if (wheelLoaded || ScreenManager.instance == null || WalletManager.wallet == null) return;
        await PopulateRewards();
    }
    async Task WaitForNewRewardOrAbortAfter(float waitTime = 120f, int delayMiliseconds = 15000){
        float startTime = Time.time;
        while (Time.time - startTime < waitTime){
            await Task.Delay(delayMiliseconds);
            waitTime -= Time.deltaTime;
            var newRewardsResult = await Inventory.QueryNewRewards();
            if (newRewardsResult.Item1 == true){
                var newRewards = newRewardsResult.Item2;
                if (newRewards.Count > 0){
                    int index = -1;
                    for (int i = 0; i < pickerWheel.wheelPieces.Length; ++i){
                        for (int j = 0; j < newRewards.Count; ++j){
                            if (pickerWheel.wheelPieces[i].Label == newRewards[j].label){
                                index = i;
                            }
                        }
                    }
                    pickerWheel.LandOn(index);
                    return;
                }
            } 
        }
        ShowReadyUI();
        pickerWheel.StopSpinning();
        Popup.instance.ShowPopup("Error", "Error happened while spinning the wheel. Try again later.");
    }
    void ShowSpinningUI(){
        spinningButton.gameObject.SetActive(false);
        backButton.gameObject.SetActive(false);
        spinningText.SetActive(true);
    }
    void ShowReadyUI(){
        spinningButton.gameObject.SetActive(true);
        backButton.gameObject.SetActive(true);
        spinningText.SetActive(false);
        UpdateTxHash("");
    }
    async void RequestSpin(){
        if (wheelLoaded && !pickerWheel.IsSpinning){
            ShowSpinningUI();
            pickerWheel.StartSpinning();
            try{
                var spinTransaction = await WalletManager.wallet.CreateExecuteContractTransaction(
                    woFContractAddress,
                    "{\"spin\": {\"number\": 1}}",
                    Constant.AURA_DENOM,
                    "101000", //for each spin
                    "1000"
                );
                await WalletManager.wallet.SignTransaction(spinTransaction);
                var spinResult = await InAppWallet.BroadcastTx(spinTransaction);
                Tebug.Log(spinResult.StatusCode, spinResult.Content);
                JObject spinResultJO = JObject.Parse(spinResult.Content);
                if (spinResult.StatusCode == 200){
                    if (spinResultJO["tx_response"] != null && spinResultJO["tx_response"]["txhash"] != null){
                        if (spinResultJO["tx_response"]["data"] != null && !string.IsNullOrWhiteSpace(spinResultJO["tx_response"]["data"].ToString())){
                            UpdateTxHash(spinResultJO["tx_response"]["txhash"].ToString());
                            await WaitForNewRewardOrAbortAfter();
                        } else if (spinResultJO["tx_response"]["raw_log"] != null && !string.IsNullOrWhiteSpace(spinResultJO["tx_response"]["raw_log"].ToString())){
                            throw new System.Exception(spinResultJO["tx_response"]["raw_log"].ToString());
                        } else {
                            throw new System.Exception("Unknown error");
                        }
                    } else {
                        throw new System.Exception("Failed to parse txHash");
                    }
                } else if (spinResultJO["message"] != null) {
                    if (spinResultJO["code"] != null && spinResultJO["code"].ToString().Equals("2")) {//time out in block mode
                        txHashText.text = "The network is taking longer to confirm your transaction";
                        await WaitForNewRewardOrAbortAfter();
                    } else {
                        throw new System.Exception(spinResultJO["message"].ToString());
                    }
                } else {
                    throw new System.Exception("Unknown error");
                }
            } catch (System.Exception e){
                ShowReadyUI();
                pickerWheel.StopSpinning();
                Popup.instance.ShowPopup("Error Spinning", $"Error(s) happened spinning the wheel: {e.Message}. Try again later!");
            }
        }
    }
    async Task PopulateRewards(){
        Loading.instance.Show("Loading wheel reward");
        wheelLoaded = false;
        var httpRewardInfo = await InAppWallet.QuerySmartContract(
            contractAddress: woFContractAddress,
            queryJson: "{\"get_wheel_rewards\":{}}");
        
        Tebug.Log(httpRewardInfo.StatusCode, httpRewardInfo.Content);
        if (httpRewardInfo.StatusCode == 200){
            JObject rewardInfo = JObject.Parse(httpRewardInfo.Content);
            JArray rewardArray = JArray.Parse(rewardInfo["data"][1].ToString());
            WheelPiece[] newPieceSet = new WheelPiece[rewardArray.Count];
            for (int i = 0; i < rewardArray.Count; ++i){
                JObject reward = JObject.Parse(rewardArray[i].ToString());
                string[] rewardTypes = {
                    "nft_collection", 
                    "fungible_token",
                    "coin",
                    "text"
                };
                foreach (string type in rewardTypes){
                    if (reward[type] != null){
                        string label = reward[type]["label"].ToString();
                        // Tebug.Log("Wheel Reward:", type, label, $"reward_icons/{label}");
                        newPieceSet[i] = new WheelPiece() {
                            Index = i,
                            Amount = i,
                            Chance = 1f / (float) rewardArray.Count,
                            Icon = Reward.GetSprite(label),
                            Label = label
                        };
                    } 
                }
            }
            pickerWheel.wheelPieces = newPieceSet;
            pickerWheel.ReInit();
            wheelLoaded = true;
        } else {
            Popup.instance.ShowPopup("Error", "Cannot fetch data from smart contract. Close the popup to try again.", async () => {
                await PopulateRewards();
            });
        }
        Loading.instance.Hide();
    }
}
