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
    public const string woFContractAddress = "aura158kn7jhsvttsmhn4q9jf2mteu5nsq8e6lxrfgmnhzg55ghftfh6qngxk6g"; //EUPHORIA
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
    bool wheelLoaded = false;
    void Start()
    {
        spinningButton.onClick.AddListener(() => {
            RequestSpin();
        });
        pickerWheel.OnSpinEnd((piece) => {
            Tebug.Log("Spinning finished");
            spinningText.SetActive(false);
            spinningButton.gameObject.SetActive(true);
            backButton.SetActive(true);
            Popup.instance.ShowPopup("Reward arrived", $"You have got {piece.Label}");
        });
        spinningText.SetActive(false);
    }
    async void OnEnable(){
        if (wheelLoaded || ScreenManager.instance == null || WalletManager.wallet == null) return;
        await PopulateRewards();
    }
    async Task WaitForNewRewardOrAbortAfter(float seconds = 120f){
        float startTime = Time.time;
        while (Time.time - startTime < seconds){
            await Task.Delay(15000);
            seconds -= Time.deltaTime;
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
                    "1000", //for each spin
                    "300"
                );
                await WalletManager.wallet.SignTransaction(spinTransaction);
                var spinResult = await InAppWallet.BroadcastTx(spinTransaction);
                Tebug.Log(spinResult.StatusCode, spinResult.Content);
                if (spinResult.StatusCode == 200){
                    await WaitForNewRewardOrAbortAfter();
                } else {
                    throw new System.Exception();
                }
            } catch {
                ShowReadyUI();
                pickerWheel.StopSpinning();
                Popup.instance.ShowPopup("Error Spinning", "Error(s) happened spinning the wheel. Try again later.");
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
                            Icon = Resources.Load<Sprite>($"reward_icons/{label}"),
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
