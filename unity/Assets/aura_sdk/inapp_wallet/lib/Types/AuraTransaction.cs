namespace AuraSDK{
    public enum TransactionType{
        SEND,
        RECEIVE
    }
    public class AuraTransaction{
        /// <summary>
        /// Bech32 address that indicates the source account sending the money.
        /// </summary>
        public string fromAddress;
        /// <summary>
        /// Bech32 address indicating the destination account which receives the money.
        /// </summary>
        public string toAddress;
        /// <summary>
        /// The denom in which the amount is.
        /// </summary>
        public string denom;
        /// <summary>
        /// The amount of money in string.
        /// </summary>
        public string amount;
        /// <summary>
        /// Timestamp of the transaction recognized by the chain.
        /// </summary>
        public string timestamp;
        public TransactionType type;
    }
}