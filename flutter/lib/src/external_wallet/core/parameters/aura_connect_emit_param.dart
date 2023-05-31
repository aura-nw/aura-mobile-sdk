class ConnectEmitData {
  final String type;
  final ConnectEmitMessage message;

  const ConnectEmitData({
    required this.type,
    required this.message,
  });

  Map<String,dynamic> toJson(){
    return {
      'type' : type,
      'message' : message.toJson(),
    };
  }
}

class ConnectEmitMessage {
  final String dAppUrl;
  final String? id;

  const ConnectEmitMessage({
    required this.dAppUrl,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': dAppUrl,
      'id': id,
    };
  }
}
