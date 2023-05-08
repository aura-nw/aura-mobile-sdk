enum TransactionType { send, receive }

class AuraTransaction {
  final String fromAddress;
  final String toAddress;
  final String amount;
  final String timestamp;
  final TransactionType type;

  AuraTransaction(
      this.fromAddress, this.toAddress, this.amount, this.timestamp, this.type);
}