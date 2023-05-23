using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AuraMobileSDK;

public class DemoIAW : MonoBehaviour
{
    public static DemoIAW instance;
    public static AuraWallet wallet;
    void Awake(){
        instance = this;
    }
    public enum Screen{
        MAIN_MENU,
        RANDOM_WALLET,
        RESTORE_WALLET,
        CHECK_BALANCE,
        MAKE_TRANSACTION,
        TRANSACTION_HISTORY
    }
    Screen _currentScreen = Screen.MAIN_MENU;
    public Screen currentScreen { get {
        return _currentScreen;
    }
    set{
        _currentScreen = value;
        UpdateUI();
    }}
    [SerializeField]
    Button btn_randomWallet, btn_restoreWallet, btn_checkBalance, btn_makeTransaction, btn_transactionHistory;
    [SerializeField]
    GameObject go_mainMenu, go_randomWallet, go_restoreWallet, go_checkBalance, go_makeTransaction, go_transactionHistory;
    void Start()
    {
        btn_randomWallet.onClick.AddListener(() => currentScreen = Screen.RANDOM_WALLET);
        btn_restoreWallet.onClick.AddListener(() => currentScreen = Screen.RESTORE_WALLET);
        btn_checkBalance.onClick.AddListener(() => currentScreen = Screen.CHECK_BALANCE);
        btn_makeTransaction.onClick.AddListener(() => currentScreen = Screen.MAKE_TRANSACTION);
        btn_transactionHistory.onClick.AddListener(() => currentScreen = Screen.TRANSACTION_HISTORY);
        UpdateUI();
    }
    void UpdateUI(){
        btn_checkBalance.gameObject.SetActive(wallet != null);
        btn_makeTransaction.gameObject.SetActive(wallet != null);
        btn_transactionHistory.gameObject.SetActive(wallet != null);
        go_mainMenu.SetActive(false);
        go_randomWallet.SetActive(false);
        go_restoreWallet.SetActive(false);
        go_checkBalance.SetActive(false);
        go_makeTransaction.SetActive(false);
        go_transactionHistory.SetActive(false);
        switch(currentScreen){
            case Screen.MAIN_MENU: go_mainMenu.SetActive(true); break;
            case Screen.RANDOM_WALLET: go_randomWallet.SetActive(true); break;
            case Screen.RESTORE_WALLET: go_restoreWallet.SetActive(true); break;
            case Screen.CHECK_BALANCE: go_checkBalance.SetActive(true); break;
            case Screen.MAKE_TRANSACTION: go_makeTransaction.SetActive(true); break;
            case Screen.TRANSACTION_HISTORY: go_transactionHistory.SetActive(true); break;
        }
    }
}
