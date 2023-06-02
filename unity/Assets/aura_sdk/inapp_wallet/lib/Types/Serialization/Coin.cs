using Newtonsoft.Json;
namespace AuraSDK.Serialization{
    public class Coin{
        [JsonProperty(PropertyName = "denom")]
        public string denom;
        [JsonProperty(PropertyName = "amount")]
        public string amount;
    }
}