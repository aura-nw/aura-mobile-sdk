using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AuraMobileSDK;

public class RandomWallet : MonoBehaviour
{
    [SerializeField]
    Button generate;
    [SerializeField]
    TMPro.TMP_Text mnemonic;
    void Start()
    {
        generate.onClick.AddListener(() => {
            DemoIAW.wallet = AuraWallet.CreateRandomHDWallet();
            mnemonic.text = DemoIAW.wallet.mnemonic;
        });
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
