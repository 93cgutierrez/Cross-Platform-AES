import Flutter
import UIKit

public class SwiftCryptlibPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cryptlib", binaryMessenger: registrar.messenger())
    let instance = SwiftCryptlibPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("inside handle")
    if call.method.elementsEqual("getEncryptedString") {
        let arguments = call.arguments as? NSDictionary
        let key = arguments!["key"] as! String
        let text = arguments!["text"] as! String
        let cryptLib = CryptLib()
        result(cryptLib.encryptPlainTextRandomIV(withPlainText: text, key: key))
    } else if call.method.elementsEqual("getDecryptedString") {
        let arguments = call.arguments as? NSDictionary
        let key = arguments!["key"] as! String
        let text = arguments!["encryptedText"] as! String
        let cryptLib = CryptLib()
        result(cryptLib.decryptCipherTextRandomIV(withCipherText: text, key: key))
    } else {
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
