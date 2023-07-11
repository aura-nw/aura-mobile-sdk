using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Michsky.MUIP;
using TUtils;
public class ScreenButton : MonoBehaviour
{
    [SerializeField]
    Screen screenToOpen;
    void Start()
    {
        GetComponent<ButtonManager>().onClick.AddListener(() => {
            Tebug.Log("Showing", screenToOpen);
            ScreenManager.instance.ShowScreen(screenToOpen);
        });
    }
}
