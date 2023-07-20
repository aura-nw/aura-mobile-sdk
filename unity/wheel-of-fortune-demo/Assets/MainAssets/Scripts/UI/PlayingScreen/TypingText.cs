using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using TUtils;
public class TypingText : MonoBehaviour
{
    [SerializeField]
    string[] texts;
    [SerializeField]
    bool runOnStart;
    [SerializeField]
    float speedMulitiplier = 1f;
    bool animating = false;
    TMP_Text text;
    void Start()
    {
        text = GetComponent<TMP_Text>();
        if (runOnStart) 
            StartAnimatingText();
    }
    const float SPACE_DELAY = 0.25f, CHAR_DELAY = 0.1f, SENTENCE_DELAY = 1f;
    int sentence_index = 0, char_index = 0;
    float cooldown = -1f;
    public void StartAnimatingText(){
        animating = true;
        char_index = sentence_index = 0;
    }
    public void StopAnimatingText(){
        animating = false;
    }
    void Update()
    {
        if (animating){
            if (cooldown < 0){
                if (char_index == 0) text.text = "";
                text.text += texts[sentence_index][char_index];
                if (++char_index < texts[sentence_index].Length)
                    cooldown = texts[sentence_index][char_index] == ' ' ? SPACE_DELAY / speedMulitiplier : CHAR_DELAY / speedMulitiplier;
                else {
                    cooldown = SENTENCE_DELAY / speedMulitiplier;
                    sentence_index = (sentence_index + 1) % texts.Length;
                    char_index = 0;
                }
                
            } else cooldown -= Time.deltaTime;
        }
    }
}
