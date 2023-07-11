using Newtonsoft.Json;
namespace AuraSDK.Serialization{
    public class TypeValue<T>{
        [JsonProperty(PropertyName = "type")]
        public string type;
        [JsonProperty(PropertyName = "value")]
        public T value;
    }
}