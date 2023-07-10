using UnityEngine;
using UnityEngine.UI;
using AuraSDK;

public class DemoIAW : MonoBehaviour
{
    public static DemoIAW instance;
    public static InAppWallet wallet;
    void Awake(){
        instance = this;
    }
    public enum Screen{
        MAIN_MENU,
        RANDOM_WALLET,
        RESTORE_WALLET,
        CHECK_BALANCE,
        MAKE_TRANSACTION,
        SEND_NFT
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
    Button btn_randomWallet, btn_restoreWallet, btn_checkBalance, btn_makeTransaction, btn_sendNFT;
    [SerializeField]
    GameObject go_mainMenu, go_randomWallet, go_restoreWallet, go_checkBalance, go_makeTransaction, go_sendNFT;
    void Start()
    {
        btn_randomWallet.onClick.AddListener(() => currentScreen = Screen.RANDOM_WALLET);
        btn_restoreWallet.onClick.AddListener(() => currentScreen = Screen.RESTORE_WALLET);
        btn_checkBalance.onClick.AddListener(() => currentScreen = Screen.CHECK_BALANCE);
        btn_makeTransaction.onClick.AddListener(() => currentScreen = Screen.MAKE_TRANSACTION);
        btn_sendNFT.onClick.AddListener(() => currentScreen = Screen.SEND_NFT);
        UpdateUI();
    }
    void UpdateUI(){
        btn_checkBalance.gameObject.SetActive(wallet != null);
        btn_makeTransaction.gameObject.SetActive(wallet != null);
        btn_sendNFT.gameObject.SetActive(wallet != null);
        go_mainMenu.SetActive(false);
        go_randomWallet.SetActive(false);
        go_restoreWallet.SetActive(false);
        go_checkBalance.SetActive(false);
        go_makeTransaction.SetActive(false);
        go_sendNFT.SetActive(false);
        switch(currentScreen){
            case Screen.MAIN_MENU: go_mainMenu.SetActive(true); break;
            case Screen.RANDOM_WALLET: go_randomWallet.SetActive(true); break;
            case Screen.RESTORE_WALLET: go_restoreWallet.SetActive(true); break;
            case Screen.CHECK_BALANCE: go_checkBalance.SetActive(true); break;
            case Screen.MAKE_TRANSACTION: go_makeTransaction.SetActive(true); break;
            case Screen.SEND_NFT: go_sendNFT.SetActive(true); break;
        }
    }
}
