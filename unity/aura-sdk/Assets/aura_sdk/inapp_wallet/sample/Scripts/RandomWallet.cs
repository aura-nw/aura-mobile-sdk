using UnityEngine;
using UnityEngine.UI;
using AuraSDK;

public class RandomWallet : MonoBehaviour
{
    [SerializeField]
    Button generate;
    [SerializeField]
    TMPro.TMP_Text mnemonic;
    void Start()
    {
        generate.onClick.AddListener(() => {
            DemoIAW.wallet = InAppWallet.CreateRandomHDWallet();
            mnemonic.text = DemoIAW.wallet.mnemonic;
        });
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
