import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'aura_connect_sdk_platform_interface.dart';

/// An implementation of [Coin98ConnectSdkPlatform] that uses method channels.
class MethodChannelAuraConnectSdk extends AuraConnectSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('aura_connect_sdk_launcher_platform');

  @override
  Future<bool> launchUrl(String url) async {
    final result = await methodChannel.invokeMethod('open_app', url);

    Map<String, dynamic> results = Map<String, dynamic>.from(result);

    return results['result'] ?? false;
  }

  @override
  Future<bool> canLaunch(String url) async {
    final result = await methodChannel.invokeMethod('can_open', url);

    Map<String, dynamic> results = Map<String, dynamic>.from(result);

    return results['result'] ?? false;
  }
}
