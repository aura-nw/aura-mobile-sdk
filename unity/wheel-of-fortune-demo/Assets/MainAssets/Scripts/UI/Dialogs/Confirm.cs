using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.MUIP;
using TUtils;
public class Confirm : MonoBehaviour
{
    public static Confirm instance;
    void Awake(){
        instance = this;
    }
    ModalWindowManager modalWindowManager;
    // Start is called before the first frame update
    void Start()
    {
        Watcher.ScheduleNextFrame(() => {
            modalWindowManager = GetComponentInChildren<ModalWindowManager>(true);
            modalWindowManager.showCancelButton = true;
            modalWindowManager.showConfirmButton = true;
            modalWindowManager.closeOnConfirm = true;
            modalWindowManager.closeOnCancel = true;
            modalWindowManager.Close();
        }, false);
    }
    public void ShowConfirmation(string title, string description, System.Action onConfirm, System.Action onCancel){
        modalWindowManager.Open();
        modalWindowManager.titleText = title;
        modalWindowManager.descriptionText = description;
        modalWindowManager.UpdateUI();
        modalWindowManager.onCancel.RemoveAllListeners();
        modalWindowManager.onCancel.AddListener(() => {
            modalWindowManager.Close();
            onCancel?.Invoke();
        });
        modalWindowManager.onConfirm.RemoveAllListeners();
        modalWindowManager.onConfirm.AddListener(() => {
            modalWindowManager.Close();
            onConfirm?.Invoke();
        });
    }
}
