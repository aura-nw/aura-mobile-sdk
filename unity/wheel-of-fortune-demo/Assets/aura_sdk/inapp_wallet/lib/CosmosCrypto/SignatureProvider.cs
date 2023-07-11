using System.Security.Cryptography;
using NBitcoin.Secp256k1;

namespace AuraSDK
{
    public class SignatureProvider
    {
        public static byte[] Sign(byte[] bytesToSign, byte[] privateKey)
        {
            
            return SignSecp256k1(bytesToSign, privateKey);
        }

        public static bool VerifySignature(byte[] message, byte[] sign, byte[] publicKey)
        {
            if (!Context.Instance.TryCreatePubKey(publicKey, out var key))
            {
                Logging.Warning("Cannot create public key from the input bytes");
                return false;
            }

            if (!SecpECDSASignature.TryCreateFromCompact(sign, out var secpEcdsaSignature))
            {
                Logging.Warning("Cannot create ECDSA signature from the compact signature.");
                return false;
            }

            var sha = new SHA256Managed();
            return key.SigVerify(secpEcdsaSignature, sha.ComputeHash(message));
        }
        static byte[] SignSecp256k1(byte[] bytesToSign, byte[] key)
        {
            var sha = new SHA256Managed();
            var hashed = sha.ComputeHash(bytesToSign);
            var ecKey = Context.Instance.CreateECPrivKey(key);
            var signature = ecKey.SignECDSARFC6979(hashed);
            var signedBytes = new byte[64];
            signature.WriteCompactToSpan(signedBytes);
            return signedBytes;
        }
    }
}