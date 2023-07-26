using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Michsky.MUIP;
using TUtils;
using AuraSDK;
using Newtonsoft.Json.Linq;
using System.Threading.Tasks;
public class Inventory : MonoBehaviour
{
    public static Inventory instance;
    public static List<Reward> rewardList = new List<Reward>();
    public static void AddReward(string type, string text){
        rewardList.Add(new Reward() {
            type = type,
            label = text
        });
    }
    public static void ClearRewardCache(){
        rewardList.Clear();
    }
    public static async Task<(bool, List<Reward>)> QueryNewRewards(){
        if (WalletManager.wallet != null){
            var playerReward = await InAppWallet.QuerySmartContract(
                contractAddress: Wheel.woFContractAddress,
                queryJson: "{\"get_player_rewards\":{\"address\": \"" + WalletManager.wallet.address + "\"}}");
            Tebug.Log("{\"get_player_rewards\":{\"address\": \"" + WalletManager.wallet.address + "\"}}", "player rewards:", playerReward.StatusCode, playerReward.Content);
            if (playerReward.StatusCode == 200){
                List<Reward> newRewards = new List<Reward>();
                JObject json = JObject.Parse(playerReward.Content);
                JArray data = JArray.Parse(json["data"].ToString());
                for (int i = rewardList.Count; i < data.Count; ++i){
                    JObject reward = JObject.Parse(data[i][1].ToString());
                    string[] rewardTypes = {
                        "nft_collection", 
                        "fungible_token",
                        "coin",
                        "text"
                    };
                    foreach (string type in rewardTypes){
                        if (reward[type] != null){
                            string label = reward[type]["label"].ToString();
                            newRewards.Add(new Reward() {
                                label = label,
                                type = type
                            });
                            rewardList.Add(new Reward() {
                                label = label,
                                type = type
                            });
                        } 
                    }
                }
                instance?.UpdateUI();
                return (true, newRewards);
            } else {
                return (false, null);
            }
        }
        return (false, null);
    }
    void Awake(){
        instance = this;
    }
    ListView listView;
    void Start()
    {
        listView = GetComponentInChildren<ListView>();
        if (listView != null){
            listView.rowCount = ListView.RowCount.Two;
        }
        UpdateUI();
    }
    void OnEnable(){
        UpdateUI();
    }
    void UpdateUI()
    {
        Tebug.Log("updatingui", rewardList.Count);
        if (listView == null) return;
        listView.listItems.Clear();
        for (int i = 0; i < rewardList.Count; ++i){
            if (rewardList[i].type == "text") continue;
            ListView.ListItem item = new ListView.ListItem();
            item.row0 = new ListView.ListRow();
            item.row1 = new ListView.ListRow();
            item.itemTitle = rewardList[i].label;
            item.row0.rowType = ListView.RowType.Icon;
            item.row0.rowIcon = rewardList[i].GetSprite();
            item.row1.rowType = ListView.RowType.Text;
            item.row1.rowText = rewardList[i].label;
            listView.listItems.Add(item);
        }
        listView?.InitializeItems();
    }
}
