using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using Chaos.NaCl;
using System.Numerics;
using Ecdsa.Secp;
using AuraMobileSDK;

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
                //// Logging.Verbose("MasterKeyFromSeed:", Convert.ToBase64String(il), Convert.ToBase64String(ir), Convert.ToBase64String(i));
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
                //// Logging.Verbose("MasterKeyFromSeed:", Convert.ToBase64String(il), Convert.ToBase64String(ir), Convert.ToBase64String(i));
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
            // Logging.Verbose("With index = ", index % hardenedOffset, "hashing", buffer.ToArray().ToHexString(), "with chaincode = ", chainCode.ToHexString());
            using (HMACSHA512 hmacSha512 = new HMACSHA512(chainCode))
            {
                var i = hmacSha512.ComputeHash(buffer.ToArray());

                var il = i.Slice(0, 32);
                var ir = i.Slice(32);

                BigInteger bKey = key.ToHexString().ToBigInteger();
                BigInteger bLeft = il.ToHexString().ToBigInteger();
                // Logging.Verbose("bLeft:", bLeft.ToString(), il.ToHexString());
                // Logging.Verbose("bKey:", bKey.ToString(), key.ToHexString());
                BigInteger newKey = (bKey + bLeft) % ECC_N;

                return (Key: newKey.ToByteArray(isUnsigned: true, isBigEndian: true), ChainCode: ir);
            }
        }

        public byte[] GetPublicKey(byte[] privateKey)
        {
            Secp256k1 secp256K1 = new Secp256k1();
            // // Logging.Verbose("publicKeyBytes sec:", secp256K1.CompressKey(secp256K1.DerivePubKeyFromPrivKey(privateKey)).ToHexString());
            return secp256K1.CompressKey(secp256K1.DerivePubKeyFromPrivKey(privateKey));
            // //This function assumes that compressed = true; then append the prefix of \x02 or \x03 when pointY is event or odd, respectively
            // BigInteger secret = HexStringToBigInteger(ByteArrayToHexString(privateKey)) % ECC_N;
            // //scalar multiplication

            // BigInteger currentX = ECC_GX;
            // BigInteger currentY = ECC_GY;
            
            // BigInteger pointX = 0;
            // BigInteger pointY = 0;
            
            // BigInteger s = secret;
            // while (s > 0) {
            //     if (s % 2 == 1){
            //         pointX += currentX;
            //         pointY += currentY;
            //     }
            //     currentX += currentX;
            //     currentY += currentY;
            //     s /= 2;
            // }

            // // Logging.Verbose("secret", ByteArrayToHexString(secret.ToByteArray(true, true)), "point", ByteArrayToHexString(pointX.ToByteArray()), ByteArrayToHexString(pointY.ToByteArray()));
            // byte[] prefix;
            // if (pointY % 2 == 0) {
            //     prefix = new byte[] {2};
            // } else {
            //     prefix = new byte[] {3};
            // }
            // // Logging.Verbose("publicKeyBytes:", ByteArrayToHexString(prefix.Concat(pointX.ToByteArray(true, true)).ToArray()));
            // return prefix.Concat(pointX.ToByteArray(true, true)).ToArray();
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
            // Logging.Verbose(segments);
            var results = segments
                .Aggregate(masterKeyFromSeed, (mks, next) => GetChildKeyDerivation(mks.Key, mks.ChainCode, next));

            return results;
        }
        public (byte[] Key, byte[] ChainCode) DerivePath(string path, byte[] seed)
        {
            if (!IsValidPath(path))
                throw new FormatException("Invalid derivation path");

            var masterKeyFromSeed = GetMasterKeyFromSeed(seed);
            // Logging.Verbose("Master key:", System.BitConverter.ToString(masterKeyFromSeed.Key).ToLower().Replace("-", ""));

            var segments = path
                .Split('/')
                .Slice(1)
                .Select(a => {
                    if (a.EndsWith("'"))
                        return Convert.ToUInt32(a.Substring(0, a.Length - 1), 10) + hardenedOffset;
                    else return Convert.ToUInt32(a, 10);
                });
            // Logging.Verbose(segments);
            var results = segments
                .Aggregate(masterKeyFromSeed, (mks, next) => {
                    // Logging.Verbose(next % hardenedOffset, System.BitConverter.ToString(mks.Key).ToLower().Replace("-", ""));
                    return GetChildKeyDerivation(mks.Key, mks.ChainCode, next);
                });

            return results;
        }

    }
}