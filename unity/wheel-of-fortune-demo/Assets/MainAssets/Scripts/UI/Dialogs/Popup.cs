using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.MUIP;
using TUtils;
using System;

public class Popup : MonoBehaviour
{
    public static Popup instance;
    void Awake(){
        instance = this;
    }
    ModalWindowManager modalWindowManager;
    // Start is called before the first frame update
    void Start()
    {
        Watcher.ScheduleNextFrame(() => {
            modalWindowManager = GetComponentInChildren<ModalWindowManager>(true);
            modalWindowManager.showCancelButton = false;
            modalWindowManager.closeOnConfirm = true;
            modalWindowManager.Close();
        }, false);
    }
    public void ShowPopup(string title, string description, Action onClose = null){
        modalWindowManager.gameObject.SetActive(true);
        modalWindowManager.Open();
        modalWindowManager.titleText = title;
        modalWindowManager.descriptionText = description;
        modalWindowManager.UpdateUI();
        modalWindowManager.onConfirm.RemoveAllListeners();
        modalWindowManager.onConfirm.AddListener(() => {
            modalWindowManager.Close();
            onClose?.Invoke();
        });
    }
}
