using Org.BouncyCastle.Math;
using System.Linq;
using System;
namespace AuraSDK{
    public static class BitSupporter {
        public static string ToHexString(this byte[] bytes){
            return System.BitConverter.ToString(bytes.ToArray()).ToLower().Replace("-", "");
        }
        public static string ToASCIIString(this byte[] bytes){
            return System.Text.Encoding.ASCII.GetString(bytes);
        }
        public static string ToUTF8String(this byte[] bytes){
            return System.Text.Encoding.UTF8.GetString(bytes);
        }
        public static string ToBase64String(this byte[] bytes){
            return System.Convert.ToBase64String(bytes);
        }
        public static BigInteger ToBigInteger(this string hexString){
            return new BigInteger("0" + hexString, 16);
        }
        public static byte[] ToByteArrayASCII(this string s){
            return System.Text.Encoding.ASCII.GetBytes(s);
        }
        public static byte[] ToByteArrayUTF8(this string s){
            return System.Text.Encoding.UTF8.GetBytes(s);
        }
        public static byte[] ToByteArrayHex(this string hex) {
            return Enumerable.Range(0, hex.Length)
                            .Where(x => x % 2 == 0)
                            .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                            .ToArray();
        }
    }
}