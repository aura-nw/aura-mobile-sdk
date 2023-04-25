class AuraServerEventTypeData {
  final dynamic result;
  final String idConnection;

  const AuraServerEventTypeData({this.result, required this.idConnection});

  factory AuraServerEventTypeData.fromJson(Map<String, dynamic> json) {
    return AuraServerEventTypeData(
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

class AuraServerEventType {
  final String type;
  final AuraServerEventTypeData? data;

  const AuraServerEventType({
    required this.type,
    this.data,
  });

  factory AuraServerEventType.fromJson(Map<String, dynamic> json) {
    return AuraServerEventType(
      type: json['type'],
      data: AuraServerEventTypeData.fromJson(
        json['data'],
      ),
    );
  }
}
