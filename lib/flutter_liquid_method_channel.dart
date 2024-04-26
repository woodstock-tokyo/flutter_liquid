import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_liquid_platform_interface.dart';

/// An implementation of [FlutterLiquidPlatform] that uses method channels.
class MethodChannelFlutterLiquid extends FlutterLiquidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_liquid');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
