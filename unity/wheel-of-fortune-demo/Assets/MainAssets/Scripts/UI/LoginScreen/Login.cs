using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using Michsky.MUIP;
using AuraSDK;
using UnityEngine.SceneManagement;
using TUtils;
public class Login : MonoBehaviour
{
    [SerializeField]
    TMP_InputField mnemonic;
    [SerializeField]
    ButtonManager create, restore;
    void Start()
    {
        create.onClick.AddListener(() => {
            ConfirmWallet(InAppWallet.CreateRandomHDWallet());
        });
        restore.onClick.AddListener(() => {
            if (!InAppWallet.CheckMnemonic(mnemonic.text)){
                Popup.instance.ShowPopup("Invalid Mnemonic", "You didn't seem to paste a valid mnemonic phrase. Try again");
            } else {
                ConfirmWallet(InAppWallet.RestoreHDWallet(mnemonic.text));
            }
        });
    }
    void ConfirmWallet(InAppWallet wallet){
        Confirm.instance.ShowConfirmation("Wallet Information", 
                    $"Here is your wallet information:\n\n" +
                    $"Mnemonic: {wallet.mnemonic}\n\n" + 
                    $"Address: {wallet.address}"
        , onConfirm: () => {
            WalletManager.wallet = wallet;
            ScreenManager.instance.ShowScreen(Screen.PLAYING);
            Inventory.ClearRewardCache();
            Inventory.QueryNewRewards().ConfigureAwait(false);
        }, onCancel: () => {
            //do nothing
        });
    }
}
