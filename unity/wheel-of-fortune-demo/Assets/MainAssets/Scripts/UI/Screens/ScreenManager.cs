using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using AuraSDK;

public enum Screen{
    LOGIN,
    PLAYING,
    INVENTORY
}
public class ScreenManager : MonoBehaviour
{
    public static ScreenManager instance;
    void Awake(){
        instance = this;
    }
    Dictionary<Screen, GameObject> screens;
    void Start(){
        screens = new Dictionary<Screen, GameObject>();
        foreach (var v in (Screen[]) System.Enum.GetValues(typeof(Screen))){
            for (int i = 0; i < transform.childCount; ++i)
                if (transform.GetChild(i).name == v.ToString())
                    screens[v] = transform.GetChild(i).gameObject;
        }
        ShowScreen(Screen.LOGIN);
    }
    public void ShowScreen(Screen screen){
        foreach (var v in (Screen[]) System.Enum.GetValues(typeof(Screen))){
            screens[v].SetActive(screen == v);
        }
    }
}
