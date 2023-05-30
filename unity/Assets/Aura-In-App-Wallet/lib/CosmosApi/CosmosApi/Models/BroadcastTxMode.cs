using System.Runtime.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace CosmosApi.Models
{
    [JsonConverter(typeof(StringEnumConverter))]
    public enum BroadcastTxMode
    {
        /// <summary>
        /// Return after tx commit.
        /// </summary>
        [EnumMember(Value = "BROADCAST_MODE_BLOCK")]
        Block,
        /// <summary>
        /// Return afer CheckTx.
        /// </summary>
        [EnumMember(Value = "BROADCAST_MODE_SYNC")]
        Sync,
        /// <summary>
        /// Return right away.
        /// </summary>
        [EnumMember(Value = "BROADCAST_MODE_ASYNC")]
        Async,
    }
}