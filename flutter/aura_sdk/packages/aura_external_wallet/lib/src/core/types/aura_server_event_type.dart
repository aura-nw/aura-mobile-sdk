class AuraSocketServerEventTypeData {
  final dynamic result;
  final String idConnection;

  const AuraSocketServerEventTypeData({this.result, required this.idConnection});

  factory AuraSocketServerEventTypeData.fromJson(Map<String, dynamic> json) {
    return AuraSocketServerEventTypeData(
      idConnection: json['id'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idConnection,
      'result': result,
    };
  }
}

class AuraSocketServerEventType {
  final String type;
  final AuraSocketServerEventTypeData? data;

  const AuraSocketServerEventType({
    required this.type,
    this.data,
  });

  factory AuraSocketServerEventType.fromJson(Map<String, dynamic> json) {
    return AuraSocketServerEventType(
      type: json['type'],
      data: AuraSocketServerEventTypeData.fromJson(
        json['data'],
      ),
    );
  }
}
