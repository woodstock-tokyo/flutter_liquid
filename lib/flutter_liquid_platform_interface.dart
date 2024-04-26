import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_liquid_method_channel.dart';

abstract class FlutterLiquidPlatform extends PlatformInterface {
  /// Constructs a FlutterLiquidPlatform.
  FlutterLiquidPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterLiquidPlatform _instance = MethodChannelFlutterLiquid();

  /// The default instance of [FlutterLiquidPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterLiquid].
  static FlutterLiquidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterLiquidPlatform] when
  /// they register themselves.
  static set instance(FlutterLiquidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
