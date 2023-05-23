using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CosmosApi.Models;
using CosmosApi.Serialization;
using cosmos.tx.v1beta1;

namespace CosmosApi.Crypto
{
    public abstract class ICryptoService
    {
        /// <summary>
        /// Parses encoded private key.
        /// </summary>
        /// <param name="encodedKey"></param>
        /// <param name="passphrase"></param>
        /// <returns></returns>
        public abstract BinaryPrivateKey ParsePrivateKey(string encodedKey, string passphrase);

        public abstract BinaryPrivateKey ParsePrivateKey(byte[] plainKeyBytes);

        public abstract BinaryPrivateKey ParsePrivateKey(string plainHexKey);
        /// <summary>
        /// Parses public key.
        /// </summary>
        /// <param name="publicKey"></param>
        /// <returns></returns>
        public abstract BinaryPublicKey ParsePublicKey(PublicKey publicKey);
        
        /// <summary>
        /// Creates a signature for given bytes.
        /// </summary>
        /// <param name="bytesToSign"></param>
        /// <param name="key"></param>
        /// <returns></returns>
        public abstract byte[] Sign(byte[] bytesToSign, BinaryPrivateKey key);

        /// <summary>
        /// Verifies sign.
        /// </summary>
        /// <param name="message">Message which was signed.</param>
        /// <param name="sign"></param>
        /// <param name="key">Public key of private key used for signing.</param>
        /// <returns>True if sign successfully verified with key.</returns>
        public abstract bool VerifySign(byte[] message, byte[] sign, BinaryPublicKey key);

        /// <summary>
        /// Tries to make public key from private.
        /// Returns null if can't.
        /// </summary>
        /// <param name="publicKey"></param>
        /// <param name="privateKey"></param>
        /// <returns></returns>
        public abstract PublicKey MakePublicKey(PublicKey publicKey, BinaryPrivateKey privateKey);

        /// <summary>
        /// Verifies sign.
        /// </summary>
        /// <param name="message">Message which was signed.</param>
        /// <param name="sign"></param>
        /// <param name="key">Public key of private key used for signing.</param>
        /// <returns>True if sign successfully verified with key.</returns>
        public virtual bool VerifySign(byte[] message, byte[] sign, PublicKey key)
        {
            return VerifySign(message, sign, ParsePublicKey(key));
        }

        public virtual StdSignature MakeStdSignature(string chainId, ulong accountNumber, ulong sequence, StdFee fee, IList<IMsg> msgs, string memo,
            ISerializer serializer, string encodedPrivateKey, string passphrase, PublicKey publicKey = default)
        {
            var key = ParsePrivateKey(encodedPrivateKey, passphrase);
            Logging.Verbose("Private key", key.Type, key.Value);
            return MakeStdSignature(chainId, accountNumber, sequence, fee, msgs, memo, serializer, key, publicKey);
        }

        public virtual StdSignature MakeStdSignature(string chainId, ulong accountNumber, ulong sequence, StdFee fee, IList<IMsg> msgs, string memo,
            ISerializer serializer, BinaryPrivateKey privateKey, PublicKey publicKey = default)
        {
            Logging.Verbose("Signing", chainId, accountNumber, sequence);
            var stdSignDoc = new StdSignDoc(accountNumber, chainId, fee, memo, msgs, sequence);

            var bytesToSign = Encoding.UTF8.GetBytes(serializer.SerializeSortedAndCompact(stdSignDoc));
            Logging.Verbose("bytesToSign", System.Text.Encoding.ASCII.GetString(bytesToSign));
            byte[] signedBytes = Sign(bytesToSign, privateKey);

            publicKey = MakePublicKey(publicKey, privateKey);
            return new StdSignature(signedBytes, publicKey);
        }
         public virtual StdSignature MakeSignature(string chainId, ulong accountNumber, ulong sequence, StdFee fee, IList<IMsg> msgs, string memo,
            ISerializer serializer, BinaryPrivateKey privateKey, PublicKey publicKey = default)
        {
            var stdSignDoc = new StdSignDoc(accountNumber, chainId, fee, memo, msgs, sequence);

            var bytesToSign = Encoding.UTF8.GetBytes(serializer.SerializeSortedAndCompact(stdSignDoc));
            byte[] signedBytes = Sign(bytesToSign, privateKey);

            publicKey = MakePublicKey(publicKey, privateKey);
            return new StdSignature(signedBytes, publicKey);
        }

        public virtual void SignStdTx(StdTx tx, IEnumerable<Signer> signers, string chainId, ISerializer serializer)
        {
            tx.Signatures = signers
                .Select(s => MakeStdSignature(chainId, s.Account.GetAccountNumber(), s.Account.GetSequence(), tx.Fee, tx.Msg, tx.Memo, serializer, s.EncodedPrivateKey, s.Passphrase, s.Account.GetPublicKey()))
                .ToList();
        } 
    }
}