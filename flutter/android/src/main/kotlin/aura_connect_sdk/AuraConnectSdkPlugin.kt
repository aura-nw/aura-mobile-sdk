package aura_mobile_sdk

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** Coin98ConnectSdkPlugin */
class AuraConnectSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var sender: Coin98ConnectSender = Coin98ConnectSender(null,null)

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "aura_mobile_sdk_launcher_platform")
    channel.setMethodCallHandler(this)

    sender.setActivity(null)
    sender.setApplicationContext(flutterPluginBinding.applicationContext)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "open_app") {

      val param = call.arguments as String?

      val results : HashMap<String,Any?> = HashMap<String,Any?>()


      if(param == null){
        results["error"] = "Url is required"

        results["result"] = false

        result.success(results)
      }else{
        try{
          val intent = Intent(Intent.ACTION_VIEW,Uri.parse(param))

          val canLaunch = sender.launch(intent)

          results["result"] = canLaunch

          if(!canLaunch){
            results["error"] = "Can't launch uri $param"
            result.success(results)
          }else{
            results["error"] = null
            result.success(results)
          }
        }catch (e : ActivityNotFoundException){
          results["error"] = "Activity not found exception"

          results["result"] = false

          result.success(results)
        }
      }

    } else if (call.method == "can_open"){
      val param = call.arguments as String?

      val results : HashMap<String,Any?> = HashMap<String,Any?>()
      if(param == null){
        results["error"] = "Url is required"

        results["result"] = false

        result.success(results)
      }else{
        try{
          val intent = Intent(Intent.ACTION_VIEW,Uri.parse(param))

          val can = sender.canLaunch(intent)

          results["error"] = null

          results["result"] = can

          result.success(results)
        }catch (e : ActivityNotFoundException){
          results["error"] = "Activity not found exception"

          results["result"] = false

          result.success(results)
        }
      }


    }else{
      val results : HashMap<String,Any> = HashMap<String,Any>()

      results["error"] = "Method not has been init"

      results["result"] = false

      result.success(results)
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    sender.setActivity(binding.activity)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    sender.setApplicationContext(null);
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    sender.setActivity(null)
  }

  override  fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }

  override  fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }
}
