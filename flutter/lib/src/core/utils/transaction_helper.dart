import 'package:alan/alan.dart';
import 'package:alan/proto/tendermint/abci/types.pb.dart';
import 'package:aura_mobile_sdk/src/core/in_app_core_data/in_app_core_data.dart';

class TransactionHelper {
  static List<AuraTransaction> convertToAuraTransaction(
      List<TxResponse> txResponse, TransactionType type) {
    List<AuraTransaction> listResult = txResponse.map((e) {
      String timeStamp = e.timestamp;
      String recipient = '';
      String sender = '';
      String amount = '';
      List<Event> listEvent = e.events;

      for (var i = 0; i < listEvent.length; i++) {
        if (listEvent[i].type == 'transfer') {
          List<EventAttribute> listAttribute = listEvent[i].attributes;
          for (var j = 0; j < listAttribute.length; j++) {
            final txAttribute = listAttribute[j];
            String keyData = String.fromCharCodes(txAttribute.key);
            String valueData = String.fromCharCodes(txAttribute.value);

            if (keyData == 'recipient') {
              recipient = valueData;
            }
            if (keyData == 'sender') {
              sender = valueData;
            }
            if (keyData == 'amount') {
              amount = valueData;
            }
          }
        }
      }
          (e) {};

      AuraTransaction auraTransaction =
      AuraTransaction(sender, recipient, amount, timeStamp, type);
      return auraTransaction;
    }).toList();
    return listResult;
  }
}