library aura_launcher;

import 'src/aura_launcher_implements.dart';

abstract class AuraLauncher{
  static final AuraLauncher _instance = AuraLauncherIml();

  static AuraLauncher get instance => _instance;

  Future<bool> openUrl(String url){
    throw UnimplementedError('openUrl not been implements');
  }

  Future<bool> canLaunch(String url){
    throw UnimplementedError('canLaunch not been implements');
  }
}