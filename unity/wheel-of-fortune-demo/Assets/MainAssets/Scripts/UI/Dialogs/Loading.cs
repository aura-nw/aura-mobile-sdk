using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.MUIP;
using TUtils;
public class Loading : MonoBehaviour
{
    public static Loading instance;
    void Awake(){
        instance = this;
    }
    void Start(){
        Hide();
    }
    [SerializeField]
    TMPro.TMP_Text text;
    public void Show(string text){
        for (int i = 0; i < transform.childCount; ++i)
            transform.GetChild(i).gameObject.SetActive(true);
        this.text.text = text;
    }
    public void Hide(){
        for (int i = 0; i < transform.childCount; ++i)
            transform.GetChild(i).gameObject.SetActive(false);
    }
}
