using Newtonsoft.Json;
namespace AuraSDK.Serialization{
    public class BaseAccount{
        [JsonProperty(PropertyName = "account_number")]
        public ulong accountNumber { get; set; }

        [JsonProperty(PropertyName = "address")]
        public string address { get; set; } = null;

        [JsonProperty(PropertyName = "public_key")]
        public TypeValue<string> publicKey { get; set; } = null;

        [JsonProperty(PropertyName = "sequence")]
        public ulong sequence { get; set; }
    }
}