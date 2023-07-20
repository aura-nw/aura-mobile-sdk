using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using AuraSDK;
using System.Numerics;
using TUtils;
using System;
using UnityEngine.UI;
using System.Threading.Tasks;
public class PlayingScreen : MonoBehaviour
{
    [SerializeField]
    GameObject depositGuideGO, wheelGO;
    [SerializeField]
    TMP_Text balanceText, addressText;
    BigInteger balance = 0;
    bool balanceUpdating = false;
    Wheel wheel;
    void Start()
    {
        wheel = wheelGO.GetComponent<Wheel>();
        balanceText.GetComponent<Button>().onClick.AddListener(UpdateBalance);
        addressText.GetComponent<Button>().onClick.AddListener(CopyAddress);
    }
    void OnEnable(){
        if (WalletManager.wallet != null){
            addressText.text = WalletManager.wallet.address;
            UpdateBalance();
        }
    }
    void CopyAddress(){
        if (WalletManager.wallet != null)
            GUIUtility.systemCopyBuffer = WalletManager.wallet.address;
    }
    void UpdateBalance(){
        if (!balanceUpdating && WalletManager.wallet != null){
            balanceUpdating = true;
            Tebug.Log("Fetching balance");
            Task<BigInteger> checkBalanceTask = WalletManager.wallet.CheckBalance(Constant.AURA_DENOM);
            checkBalanceTask.GetAwaiter().OnCompleted(() => {
                if (checkBalanceTask.IsCompletedSuccessfully)
                    balance = checkBalanceTask.Result;
                balanceUpdating = false;
                lastUpdateTime = Time.time;
            });
        }
    }
    float lastUpdateTime = -100;
    const float AUTO_UPDATE_TIME = 15f;
    void Update(){
        if (!balanceUpdating){
            float remainingAutoWaitTime = AUTO_UPDATE_TIME - Time.time + lastUpdateTime;
            if (remainingAutoWaitTime < 0){
                UpdateBalance();
            } else {
                if (balance >= 0){
                    balanceText.text = $"Account Balance: {balance.ToString()} {Constant.AURA_DENOM}\nAuto Refresh In: {(int) (AUTO_UPDATE_TIME - Time.time + lastUpdateTime)} seconds";   
                } else {
                    balanceText.text = $"Failed to query account balance\nAuto Refresh In: {(int) (AUTO_UPDATE_TIME - Time.time + lastUpdateTime)} seconds";   
                }
            }
        } else {
            balanceText.text = "Refreshing Balance...";
        }
        if (!wheelGO.activeInHierarchy || !wheel.IsSpinning){
            if (balance > WoFConfig.CONTRACT_SENDING_FEE + WoFConfig.WHEEL_SPINNING_FEE){
                wheelGO.SetActive(true);
                depositGuideGO.SetActive(false);
            } else {
                wheelGO.SetActive(false);
                depositGuideGO.SetActive(true);
            }
        }
    }
}
