using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AuraMobileSDK;

public class RestoreWallet : MonoBehaviour
{
    [SerializeField]
    Button restore;
    [SerializeField]
    TMPro.TMP_InputField mnemonic;
    void Start()
    {
        restore.onClick.AddListener(() => {
            DemoIAW.wallet = AuraWallet.RestoreAuraWallet(mnemonic.text);
        });
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
