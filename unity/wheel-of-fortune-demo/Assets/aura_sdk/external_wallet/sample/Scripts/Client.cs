using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AuraSDK;

public class Client : MonoBehaviour
{
    [SerializeField]
    string dAppName, callbackURL, logoLink, chainID;
    [SerializeField]
    Button connect, getWalletInfo, open;
    void Start() {
        ExternalWallet auraConnect = new ExternalWallet();
        connect.onClick.AddListener(() => {
            auraConnect.RequestAuthorization(dAppName, callbackURL, logoLink, chainID);
        });
        getWalletInfo.onClick.AddListener(() => {
            auraConnect.GetWalletInfo(dAppName, callbackURL, logoLink, chainID);
        });
        open.onClick.AddListener(() => {
            URLOpener.Open("coin98://c98:0057c334-2181-46f3-ac49-cad605552cbf?url=app://open.my.app&connect=EBrrGnDiId4p&request=%7B%22method%22%3A%22connect%22%2C%22params%22%3A%5B%7B%22name%22%3A%22Example%22%2C%22callbackURL%22%3A%22app%3A%2F%2Fopen.my.app%22%2C%22logo%22%3A%22logo%22%7D%5D%2C%22id%22%3A%22833101241411-63126-40515-17133-1046211101196414%22%2C%22chain%22%3A%22serenity-testnet-001%22%2C%22redirect%22%3A%22app%3A%2F%2Fopen.my.app%22%7D");
        });
    }
}
