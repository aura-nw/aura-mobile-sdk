using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using AuraMobileSDK;

public class Client : MonoBehaviour
{
    [SerializeField]
    string dAppName, callbackURL, logoLink, chainID;
    [SerializeField]
    Button connect;
    void Start() {
        connect.onClick.AddListener(() => {
            AuraConnect.Connect(dAppName, callbackURL, logoLink, chainID);
        });
    }
}
