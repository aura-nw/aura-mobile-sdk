using Newtonsoft.Json;
namespace AuraSDK.Serialization
{
    public class QueryResponse<TResult>
    {
        [JsonProperty("height")]
        public long height { get; set; }

        [JsonProperty("result")] 
        public TResult result { get; set; } = default;
    }
}