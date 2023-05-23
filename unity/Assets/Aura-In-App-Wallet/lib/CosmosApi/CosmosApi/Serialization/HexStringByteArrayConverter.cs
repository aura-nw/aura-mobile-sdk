using System;
using System.Globalization;
using CosmosApi.Extensions;
using CosmosApi.Models;
using Newtonsoft.Json;

namespace CosmosApi.Serialization
{
    public class HexStringByteArrayConverter : Newtonsoft.Json.JsonConverter
    {
        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            var array = value as byte[];

            serializer.Serialize(writer, array.ToHexString());
        }


        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            var deserializedString = serializer.Deserialize<string>(reader);

            return ByteArrayExtensions.ParseHexString(deserializedString);
        }


        public override bool CanConvert(Type objectType)
        {
            return objectType == typeof(byte[]);
        }
    }
}