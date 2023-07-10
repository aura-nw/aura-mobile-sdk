import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'aura_launcher_method_channel.dart';

abstract class AuraLauncherPlatform extends PlatformInterface {
  /// Constructs a AuraLauncherPlatform.
  AuraLauncherPlatform() : super(token: _token);

  static final Object _token = Object();

  static AuraLauncherPlatform _instance = MethodChannelAuraLauncher();

  /// The default instance of [AuraLauncherPlatform] to use.
  ///
  /// Defaults to [MethodChannelAuraLauncher].
  static AuraLauncherPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AuraLauncherPlatform] when
  /// they register themselves.
  static set instance(AuraLauncherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> openUrl(String url){
    throw UnimplementedError('openUrl not been implements');
  }

  Future<bool> canLaunch(String url){
    throw UnimplementedError('canLaunch not been implements');
  }
}
