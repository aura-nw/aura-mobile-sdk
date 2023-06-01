using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Numerics;
using Ecdsa.Secp;
using AuraSDK;

namespace dotnetstandard_bip32
{
    public class BIP32
    {
        readonly BigInteger ECC_N = "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141".ToBigInteger();
        readonly BigInteger ECC_GX = "79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798".ToBigInteger();
        readonly BigInteger ECC_GY = "483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8".ToBigInteger();
        readonly uint hardenedOffset = 0x80000000;
        string curve = "Bitcoin seed";
        public (byte[] Key, byte[] ChainCode) GetMasterKeyFromSeed(string seed)
        {
            using (HMACSHA512 hmacSha512 = new HMACSHA512(Encoding.UTF8.GetBytes(curve)))
            {
                var i = hmacSha512.ComputeHash(seed.HexToByteArray());

                var il = i.Slice(0, 32);
                var ir = i.Slice(32);
                return (Key: il, ChainCode: ir);
            }
        }
        public (byte[] Key, byte[] ChainCode) GetMasterKeyFromSeed(byte[] seed)
        {
            using (HMACSHA512 hmacSha512 = new HMACSHA512(Encoding.UTF8.GetBytes(curve)))
            {
                var i = hmacSha512.ComputeHash(seed);

                var il = i.Slice(0, 32);
                var ir = i.Slice(32);
                return (Key: il, ChainCode: ir);
            }
        }

        private (byte[] Key, byte[] ChainCode) GetChildKeyDerivation(byte[] key, byte[] chainCode, uint index)
        {
            BigEndianBuffer buffer = new BigEndianBuffer();
            if (index >= hardenedOffset){
                buffer.Write(new byte[] { 0 });
                buffer.Write(key);
                buffer.WriteUInt(index);
            } else {
                byte[] pubKey = GetPublicKey(key);
                buffer.Write(pubKey);
                buffer.WriteUInt(index);
            }
            using (HMACSHA512 hmacSha512 = new HMACSHA512(chainCode))
            {
                var i = hmacSha512.ComputeHash(buffer.ToArray());

                var il = i.Slice(0, 32);
                var ir = i.Slice(32);

                BigInteger bKey = key.ToHexString().ToBigInteger();
                BigInteger bLeft = il.ToHexString().ToBigInteger();
                BigInteger newKey = (bKey + bLeft) % ECC_N;

                return (Key: newKey.ToByteArray(isUnsigned: true, isBigEndian: true), ChainCode: ir);
            }
        }

        public byte[] GetPublicKey(byte[] privateKey)
        {
            Secp256k1 secp256K1 = new Secp256k1();
            return secp256K1.CompressKey(secp256K1.DerivePubKeyFromPrivKey(privateKey));
        }

        private bool IsValidPath(string path)
        {
            var regex = new Regex("^m(\\/[0-9]+'?)+$");

            if (!regex.IsMatch(path))
                return false;

            var valid = !(path.Split('/')
                .Slice(1)
                .Select(a => a.Replace("'", ""))
                .Any(a => !Int32.TryParse(a, out _)));

            return valid;
        }


        public (byte[] Key, byte[] ChainCode) DerivePath(string path, string seed)
        {
            if (!IsValidPath(path))
                throw new FormatException("Invalid derivation path");

            var masterKeyFromSeed = GetMasterKeyFromSeed(seed);

            var segments = path
                .Split('/')
                .Slice(1)
                .Select(a => {
                    if (a.EndsWith("'"))
                        return Convert.ToUInt32(a.Substring(0, a.Length - 1), 10) + hardenedOffset;
                    else return Convert.ToUInt32(a, 10);
                });
            var results = segments
                .Aggregate(masterKeyFromSeed, (mks, next) => GetChildKeyDerivation(mks.Key, mks.ChainCode, next));

            return results;
        }
        public (byte[] Key, byte[] ChainCode) DerivePath(string path, byte[] seed)
        {
            if (!IsValidPath(path))
                throw new FormatException("Invalid derivation path");

            var masterKeyFromSeed = GetMasterKeyFromSeed(seed);

            var segments = path
                .Split('/')
                .Slice(1)
                .Select(a => {
                    if (a.EndsWith("'"))
                        return Convert.ToUInt32(a.Substring(0, a.Length - 1), 10) + hardenedOffset;
                    else return Convert.ToUInt32(a, 10);
                });
            var results = segments
                .Aggregate(masterKeyFromSeed, (mks, next) => {
                    return GetChildKeyDerivation(mks.Key, mks.ChainCode, next);
                });

            return results;
        }

    }
}