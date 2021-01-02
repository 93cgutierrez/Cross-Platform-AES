package com.noor.cryptlib

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CryptlibPlugin */
class CryptlibPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "cryptlib")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "getPlatformVersion" -> {
          result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        "getEncryptedString" -> {
          val k = call.argument<String>("key")
          val text = call.argument<String>("text")

          try {
            val crypt = CryptLib()
            var output = ""
            output = crypt.encryptPlainTextWithRandomIV(text, k)
            println("encrypted text=$output")
            result.success(output)
          } catch (e: Exception) {
            // TODO Auto-generated catch block
            e.printStackTrace()
          }
        }
      "getDecryptedString" -> {
        val k = call.argument<String>("key")
        val text = call.argument<String>("encryptedText")
        try {
          val crypt = CryptLib()
          var output = ""
          output = crypt.decryptCipherTextWithRandomIV(text,k) //decrypt
//          println("decrypt text=$output")
          result.success(output)
        } catch (e: Exception) {
          // TODO Auto-generated catch block
          e.printStackTrace()
        }
      }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
