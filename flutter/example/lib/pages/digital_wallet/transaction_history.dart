// import 'package:aura_sdk/aura_sdk.dart';
// import 'package:flutter/material.dart';
//
// class TransactionHistory extends StatefulWidget {
//   const TransactionHistory({super.key});
//
//   @override
//   State<TransactionHistory> createState() => _TransactionHistoryState();
// }
//
// class _TransactionHistoryState extends State<TransactionHistory> {
//   List<AuraTransaction> listData = [];
//
//   TextEditingController addressController = TextEditingController();
//   String? errorMsg;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Transaction History'),
//       ),
//       body: Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text('Transaction History'),
//           ),
//           Container(
//             margin: const EdgeInsets.all(16),
//             // decoration: BoxDecoration(
//             //   border: Border.all(
//             //     color: Colors.black,
//             //     width: 1.0,
//             //   ),
//             // ),
//             child: TextField(
//               controller: addressController,
//               textAlign: TextAlign.start,
//               decoration: InputDecoration(
//                 labelText: 'Enter Address',
//                 errorText: errorMsg,
//                 hintText: 'Address',
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//           ),
//           SizedBox(
//               width: 200,
//               child: OutlinedButton(
//                 onPressed: doLoadHistory,
//                 child: const Text('Load History'),
//               )),
//           Expanded(
//             child: listData.isNotEmpty
//                 ? ListView.builder(
//                     reverse: true,
//                     padding: const EdgeInsets.all(8),
//                     itemCount: listData.length,
//                     itemBuilder: (context, index) {
//                       final item = listData[index];
//                       return createViewItem(item);
//                     },
//                   )
//                 : const SizedBox(),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   Future<void> doLoadHistory() async {
//     String address = addressController.text;
//
//     if (address.isEmpty) {
//       setState(() {
//         errorMsg = 'Please input address to check balance';
//       });
//       return;
//     }
//     errorMsg = null;
//     final List<AuraTransaction> list = await AuraSDK.instance.digitalWallet
//         .checkWalletHistory(address: address);
//     setState(() {
//       listData = list;
//     });
//   }
//
//   Widget createViewItem(AuraTransaction auraTransaction) {
//     return SizedBox(
//       width: double.infinity,
//       height: 100,
//       child: Column(children: [
//         Row(
//           children: [
//             const Text(
//               'From: ',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(auraTransaction.fromAddress)
//           ],
//         ),
//         Row(
//           children: [
//             const Text(
//               'To: ',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(auraTransaction.toAddress)
//           ],
//         ),
//         Row(
//           children: [
//             const Text(
//               'Amout: ',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(auraTransaction.amount)
//           ],
//         ),
//         Row(
//           children: [
//             const Text(
//               'Type: ',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(auraTransaction.type.name)
//           ],
//         ),
//       ]),
//     );
//   }
// }
