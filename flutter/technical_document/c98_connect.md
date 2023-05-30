
# 1. Prepare Connection
### 1. Creating a Socket 
In Dart, we can create a socket using the `io` method from the `socket.io-client` library. To do so, we can follow these steps:

1. Create a `OptionBuilder` instance to set the socket options, such as the transports, the timeout, the auto-connect, and the force-new flag.
2. Build the options using the `build` method of the `OptionBuilder`.
3. Create a `Socket` instance by calling the `io` method with the socket URL and the options.

Here's an example code snippet:

``` Dart
import 'package:socket_io_client/socket_io_client.dart';

late Socket socketClient;

void createSocket() {
  OptionBuilder otpBuilder = OptionBuilder()
    ..setTransports([webSocket])
    ..setTimeout(connectTimeOut)
    ..enableAutoConnect()
    ..enableForceNew();

  Map<String, dynamic> options = otpBuilder.build();

  socketClient = io('https://socket.coin98.services/', options);
}
```

### 2. Handling Socket Events

After creating the socket, we need to handle its events to receive data from the server. In this case, there are two events that we have to handle:

1. `sdk_connect`: This event occurs when the socket connects to the server, and it sends a payload from C98 to DApp via the socket.
2. `disconnect`: This event occurs when the socket disconnects from the server.

To handle these events, we can use the `on` method of the `Socket` instance and pass the event name and a callback function as arguments. The callback function will receive an event parameter that contains the payload data.

Here's an example code snippet:

``` Dart
socketClient.on('sdk_connect', (event) {
  print("#sdk_connect $event");
});

socketClient.on('disconnect', (event) {
  print("#disconnect $event");
});
```

# 2. Connecting the Wallet and get the connectionId

After creating a socket, we can connect the wallet using the `emitWithAck` method from the socket.io-client library. Here's how we can connect the wallet:

### 1. Create a unique id using the `Uuid` package.
``` Dart
final id = const Uuid().v4();
```

### 2. Define a Map object containing the connection request parameters.
``` Dart
final Map<String, dynamic> params = {
  "type": "connection_request",
  "message": {"url": callBackUrl, "id": id}
};
```

### 3. Call the `emitWithAck` method on the socketClient object to send the connection request to the server. This method will also return an acknowledgement with a connectionId.

``` Dart
socketClient.emitWithAck('coin98_connect', params,
    ack: (String connectionId) async {
  print("connectionId = $connectionId");
});
```

Once the connection is established, we can proceed with further operations.

# 3. Sending a Request to Coin98 to Connect

Before you can send a request to connect to Coin98, you need to follow the steps outlined below.

1. Check for Connection and Method
``` Dart
if (!isConnected && param['method'] != 'connect') {
  throw UnimplementedError('You need to connect before handling any request!!');
}
```
First, you need to check whether there is a connection and if the method is not 'connect', you should throw an error. This ensures that the connection is established before any other requests are handled.

2. Provide your App URL
``` Dart
if (callBackUrl.isEmpty) {
  throw UnimplementedError('You need to provide your app URL!!');
}
```
You also need to provide the URL for your app to receive callbacks.

3. Wait for Connection ID
``` Dart
if (connectionId.isEmpty) {
  throw UnimplementedError('Wait for ID from Coin98');
}
```
You should wait for a connection ID from Coin98 before proceeding with any requests.

4. Generate Auto ID
``` Dart
int d = DateTime.now().millisecondsSinceEpoch;

String idFormat = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';

String id = idFormat.replaceAllMapped(RegExp(r'[xy]'), (match) {
  int r = Random().nextInt(16); // random number between 0 and 16
  // Use timestamp until depleted
  r = (d + r) % 16 | 0;
  d = (d / 16).floor();
  return (match.input[match.end - match.start] == 'x' ? r : (r & 0x3) | 0x8)
      .toString();
});

param['id'] = id;
``` 
You need to generate an auto ID, which is a unique identifier for each request, and add it to the `param` map.

5. Encode Redirect URL and Chain Information
``` Dart
param['redirect'] = Uri.encodeFull(callBackUrl);

param['chain'] = 'serenity-testnet-001';
```
You should encode the redirect URL and add the chain information to the `param` map.

6. Encode URL and Open Browser
``` Dart
String url = enCodeUrl('$id&request=${enCodeRequestParam(param)}');

OpenUrl openUrl = const OpenUrl();
openUrl.openUrl(url);
```
After encoding the URL, the last step is to open the browser to send the request to Coin98 for connection. This call will automatically open the C98 Application on your mobile device and prompt you to approve the connection.