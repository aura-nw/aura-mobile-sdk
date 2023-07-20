using UnityEngine;
using UnityEngine.UI;
using AuraSDK;

public class RestoreWallet : MonoBehaviour
{
    [SerializeField]
    Button restore;
    [SerializeField]
    TMPro.TMP_InputField mnemonic;
    void Start()
    {
        restore.onClick.AddListener(() => {
            DemoIAW.wallet = InAppWallet.RestoreHDWallet(mnemonic.text);
            
            //go back to main menu
            DemoIAW.instance.currentScreen = DemoIAW.Screen.MAIN_MENU;
        });
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
