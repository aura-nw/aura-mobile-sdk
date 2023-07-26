using UnityEngine;
public class Reward{
    public string type;
    public string label;
    public Sprite GetSprite(){
        return Reward.GetSprite(this.label);
    }
    public static Sprite GetSprite(string label){
        Sprite sprite = Resources.Load<Sprite>($"reward_icons/{label}");
        if (sprite == null){
            if (label.EndsWith("aura")) sprite = Resources.Load<Sprite>("reward_icons/1aura");
        }
        return sprite;
    }
}