using System.Numerics;
using System.Linq;
namespace AuraSDK{
    public static class JSONSupporter {
        public static string SerializeToString(this object x){
            System.IO.StringWriter sW = new System.IO.StringWriter();
            Newtonsoft.Json.JsonSerializer.Create().Serialize(sW, x);
            return sW.ToString();
        }
    }
}