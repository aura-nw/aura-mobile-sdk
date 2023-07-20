using UnityEngine;
using UnityEngine.UI;
public class ShowMainMenuButton : MonoBehaviour{
    void Start(){
        GetComponent<Button>().onClick.AddListener(() => {
            DemoIAW.instance.currentScreen = DemoIAW.Screen.MAIN_MENU;
        });
    }
}