import 'package:aura_launcher/aura_launcher.dart';

import 'aura_launcher_platform_interface.dart';

class AuraLauncherIml implements AuraLauncher {
  AuraLauncherPlatform get instance => AuraLauncherPlatform.instance;

  @override
  Future<bool> canLaunch(String url) async {
    return instance.canLaunch(url);
  }

  @override
  Future<bool> openUrl(String url) async {
    return instance.openUrl(url);
  }
}
