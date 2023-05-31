import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'aura_connect_sdk_method_channel.dart';

abstract class AuraConnectSdkPlatform extends PlatformInterface {
  /// Constructs a Coin98ConnectSdkPlatform.
  AuraConnectSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static AuraConnectSdkPlatform _instance = MethodChannelAuraConnectSdk();

  /// The default instance of [Coin98ConnectSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelCoin98ConnectSdk].
  static AuraConnectSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Coin98ConnectSdkPlatform] when
  /// they register themselves.
  static set instance(AuraConnectSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> canLaunch(String url) {
    throw UnimplementedError('canLaunch() has not been implemented.');
  }

  Future<bool> launchUrl(String url) {
    throw UnimplementedError('canLaunch() has not been implemented.');
  }
}
