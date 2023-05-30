using System.Numerics;
using System.Linq;
namespace AuraMobileSDK{
    public static class BitSupporter {
        public static string ToHexString(this byte[] bytes){
            return System.BitConverter.ToString(bytes.ToArray()).ToLower().Replace("-", "");
        }
        public static BigInteger ToBigInteger(this string hexString){
            return BigInteger.Parse("0" + hexString, System.Globalization.NumberStyles.HexNumber);
        }
        public static byte[] ToByteArrayASCII(this string s){
            return System.Text.Encoding.ASCII.GetBytes(s);
        }
        public static byte[] ToByteArrayUTF8(this string s){
            return System.Text.Encoding.UTF8.GetBytes(s);
        }
    }
}