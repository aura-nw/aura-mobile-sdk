import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'aura_launcher_platform_interface.dart';

/// An implementation of [AuraLauncherPlatform] that uses method channels.
class MethodChannelAuraLauncher extends AuraLauncherPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('aura_launcher');

  @override
  Future<bool> canLaunch(String url) async {
    final result = await methodChannel.invokeMethod('can_open', url);

    Map<String, dynamic> results = Map<String, dynamic>.from(result);

    return results['result'] ?? false;
  }

  @override
  Future<bool> openUrl(String url) async {
    final result = await methodChannel.invokeMethod('open_app', url);

    Map<String, dynamic> results = Map<String, dynamic>.from(result);

    return results['result'] ?? false;
  }
}
