import 'dart:async';

import 'package:flutter/services.dart';

class Cryptlib {
  static const MethodChannel _channel = const MethodChannel('cryptlib');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> getEncryptedString(String key, String text) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("key", () => key);
    args.putIfAbsent("text", () => text);
    final String encrypted =
        await _channel.invokeMethod('getEncryptedString', args);
    return encrypted;
  }

  static Future<String> getDecryptedString(
      String key, String encryptedText) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("key", () => key);
    args.putIfAbsent("encryptedText", () => encryptedText);
    final String encrypted =
        await _channel.invokeMethod('getDecryptedString', args);
    return encrypted;
  }
}
