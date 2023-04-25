import 'dart:convert';

String enCodeUrl(String url) {
  url = Uri.encodeComponent(url);

  return url.startsWith('coin98://') ? url : 'coin98://$url';
}

String enCodeRequestParam(
  Map<String, dynamic> params,
) {
  return Uri.encodeComponent(jsonEncode(params));
}