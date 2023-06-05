namespace AuraSDK{
    public enum TransactionType{
        SEND,
        RECEIVE
    }
    public class AuraTransaction{
        public string fromAddress;
        public string toAddress;
        public string amount;
        public string timestamp;
        public TransactionType type;
    }
}