﻿using System.Security.Cryptography;
using NBitcoin;
namespace AuraSDK
{
    public class SignatureProvider
    {
        public static byte[] Sign(byte[] bytesToSign, byte[] privateKey)
        {
            return SignSecp256k1(bytesToSign, privateKey);
        }

        static uint256 GetMessageHash(byte[] message){
            var sha = new SHA256Managed();
            var hashed = sha.ComputeHash(message);
            System.Array.Reverse(hashed);
            uint256 uHashed = uint256.Parse(hashed.ToHexString());
            return uHashed;
        }
        // public static bool VerifySignature(byte[] message, byte[] signature, byte[] publicKey)
        // {
        //     PubKey pubKey = new PubKey(publicKey);
        //     uint256 mHash = GetMessageHash(message);
        //     CompactSignature compactSignature = new CompactSignature(3, signature);
        //     return compactSignature.RecoverPubKey(mHash).Equals(pubKey);
        // }
        static byte[] SignSecp256k1(byte[] bytesToSign, byte[] key)
        {
            uint256 uHashed = GetMessageHash(bytesToSign);
            // Logging.Verbose(key, key.Length);
            Key privKey = new Key(key);
            return privKey.SignCompact(uHashed, false).Signature;
        }
        
        // [UnityEngine.RuntimeInitializeOnLoadMethod]
        static void Test(){
            byte[] signDoc = new byte[] {10, 180, 1, 10, 139, 1, 10, 28, 47, 99, 111, 115, 109, 111, 115, 46, 98, 97, 110, 107, 46, 118, 49, 98, 101, 116, 97, 49, 46, 77, 115, 103, 83, 101, 110, 100, 18, 107, 10, 43, 97, 117, 114, 97, 49, 52, 99, 56, 117, 56, 107, 120, 116, 57, 114, 122, 108, 121, 103, 121, 117, 122, 115, 48, 107, 107, 51, 53, 114, 107, 122, 107, 112, 122, 50, 99, 52, 103, 116, 113, 52, 108, 107, 18, 43, 97, 117, 114, 97, 49, 106, 114, 56, 120, 48, 113, 121, 50, 109, 57, 99, 99, 112, 48, 106, 115, 108, 121, 103, 108, 110, 108, 106, 114, 103, 120, 117, 109, 118, 114, 103, 52, 114, 115, 118, 99, 110, 52, 26, 15, 10, 6, 117, 101, 97, 117, 114, 97, 18, 5, 49, 49, 49, 49, 49, 18, 36, 50, 101, 52, 51, 101, 100, 53, 100, 45, 53, 51, 55, 57, 45, 52, 99, 57, 54, 45, 97, 55, 50, 99, 45, 101, 49, 53, 54, 53, 48, 99, 49, 55, 50, 52, 98, 18, 191, 1, 10, 78, 10, 70, 10, 31, 47, 99, 111, 115, 109, 111, 115, 46, 99, 114, 121, 112, 116, 111, 46, 115, 101, 99, 112, 50, 53, 54, 107, 49, 46, 80, 117, 98, 75, 101, 121, 18, 35, 10, 33, 2, 247, 36, 24, 49, 250, 225, 254, 80, 208, 152, 36, 241, 92, 205, 243, 171, 33, 105, 28, 196, 174, 168, 77, 125, 1, 228, 129, 54, 70, 243, 38, 201, 18, 4, 10, 2, 8, 1, 18, 109, 10, 13, 10, 6, 117, 101, 97, 117, 114, 97, 18, 3, 50, 48, 48, 16, 192, 154, 12, 26, 43, 97, 117, 114, 97, 49, 52, 99, 56, 117, 56, 107, 120, 116, 57, 114, 122, 108, 121, 103, 121, 117, 122, 115, 48, 107, 107, 51, 53, 114, 107, 122, 107, 112, 122, 50, 99, 52, 103, 116, 113, 52, 108, 107, 34, 43, 97, 117, 114, 97, 49, 52, 99, 56, 117, 56, 107, 120, 116, 57, 114, 122, 108, 121, 103, 121, 117, 122, 115, 48, 107, 107, 51, 53, 114, 107, 122, 107, 112, 122, 50, 99, 52, 103, 116, 113, 52, 108, 107, 26, 10, 101, 117, 112, 104, 111, 114, 105, 97, 45, 50, 32, 134, 247, 36};
            byte[] key = new byte[] {33, 0, 118, 67, 71, 215, 96, 217, 159, 207, 226, 226, 129, 234, 143, 25, 202, 17, 118, 185, 51, 87, 29, 98, 105, 174, 91, 109, 68, 179, 162, 219};
            string gtSig = "86ab2fdb77c813119b7f90776e2ce1a7da4cdcc75fd0fff3bc0767fe30c160d340e53c8a39d5961efe8f54b91c6e009fece3463f5faae90dbb5c90178f2e9e3c";
            byte[] sigBytes = SignSecp256k1(signDoc, key);
            string sig = sigBytes.ToHexString();
            // Logging.Verbose("GT:", gtSig, gtSig.Length);
            // Logging.Verbose("Sig:", sig, sig.Length);
            if (gtSig.Equals(sig))
                Logging.Verbose("Test: Sign signature successfully");
            else Logging.Verbose("Test: Sign signature failed");

            // if (VerifySignature(signDoc, sigBytes, new dotnetstandard_bip32.BIP32().GetPublicKey(key))){
            //     Logging.Verbose("Correct signature verified OK");
            // } else {
            //     Logging.Verbose("Correct signature verified Failed");
            // }

            // sigBytes[0] = (byte) UnityEngine.Random.Range(0, 256);
            // if (VerifySignature(signDoc, sigBytes, new dotnetstandard_bip32.BIP32().GetPublicKey(key))){
            //     Logging.Verbose("Incorrect signature verified OK");
            // } else {
            //     Logging.Verbose("Incorrect signature verified Failed");
            // }
        }
    }
}

