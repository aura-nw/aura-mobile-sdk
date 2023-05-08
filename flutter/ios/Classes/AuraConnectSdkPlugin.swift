import Flutter
import UIKit

public class AuraConnectSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "aura_mobile_sdk_launcher_platform", binaryMessenger: registrar.messenger())
    let instance = AuraConnectSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method{
          case "open_app":
              guard let param = call.arguments as? String else{
                               result(["error" : "Url is required", "result" : false])

                               return
                         }
              do{
                  let canLaunch = _launcherUrl(url : param);

                  result(["error" : nil , "result" : canLaunch])
              }catch{
                  result(["error" : "Can't open url", "result" : false])
              }
          case "can_open":
             guard let param = call.arguments as? String else{
                  result(["error" : "Url is required", "result" : false])

                  return
             }
             do{
                  let canLaunch = _canLauncherUrl(url : param);

                  result(["error" : nil , "result" : canLaunch])
              }catch{
                  result(["error" : "Can't open url", "result" : false])
              }
          default:
              result(["error" : "Not provider method in channel"])
        }
    }
    private func _launcherUrl(url: String) -> Bool{
            if let compareUrl = URL(string: url){
                let canLaunch = UIApplication.shared.canOpenURL(compareUrl)

                if canLaunch{
                    UIApplication.shared.open(compareUrl)
                }

                return canLaunch
            }

            return false;
        }

    private func _canLauncherUrl(url : String) -> Bool{
            if let compareUrl = URL(string: url){
                let canLaunch = UIApplication.shared.canOpenURL(compareUrl)

                return canLaunch
            }

            return false
    }
}
