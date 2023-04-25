import 'package:aura_connect_sdk/src/core/launcher_platform/aura_launcher.dart';

class OpenUrl {
  const OpenUrl();

  Future<void> openUrl(String url) async {
    if (!await (const AuraConnectSdkLauncher().launchUrl(url))) {
      throw UnimplementedError('Aura connect wallet sdk can\'t launch $url');
    }
  }

  Future<bool> canLaunch(String url) async {
    return await const AuraConnectSdkLauncher().canLaunch(url);
  }
}
