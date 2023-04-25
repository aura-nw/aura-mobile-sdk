import 'aura_connect_sdk_platform_interface.dart';

class AuraConnectSdkLauncher {
  const AuraConnectSdkLauncher();

  Future<bool> launchUrl(String url) async{
    return AuraConnectSdkPlatform.instance.launchUrl(url);
  }

  Future<bool> canLaunch(String url) async{
    return AuraConnectSdkPlatform.instance.canLaunch(url);
  }
}
